"
I am a presenter that has a list and a text input for filtering the elements on the list.

The list items are filtered based on what the `display` method of the list returns. In other words, what you see is what is used to filter.

I have two predefined filter methods: `self enableItemBeginsWithFilter` and `self enableItemSubstringFilter`. You can set your own method be calling `self itemFilter: aBlock` with a block that has two parameters: the item and the pattern. See the definitions of the above methods for details.

I have two subwidgets:
- A List (`SpListPresenter`) that has the items.
- A Text Input Field (`SpTextInputFieldPresenter`) for entering the filter text.
"
Class {
	#name : #SpFilteringListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'unfilteredItems',
		'list',
		'filterInput',
		'itemFilterBlock'
	],
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #specs }
SpFilteringListPresenter class >> bottomLayout [

	^ SpBoxLayout newVertical
		  add: #list;
		  add: #filterInput expand: false;
		  yourself
]

{ #category : #specs }
SpFilteringListPresenter class >> defaultSpec [

	^ self bottomLayout
]

{ #category : #specs }
SpFilteringListPresenter class >> topLayout [

	^ SpBoxLayout newVertical
		  add: #filterInput expand: false;
		  add: #list;
		  yourself
]

{ #category : #api }
SpFilteringListPresenter >> applyFilter: aString [

	self filterInputPresenter text: aString
]

{ #category : #initialization }
SpFilteringListPresenter >> connectPresenters [

	filterInput whenTextChangedDo: [ :text | self filterListItems: text ]
]

{ #category : #api }
SpFilteringListPresenter >> filter [

	^  self filterInputPresenter text
]

{ #category : #api }
SpFilteringListPresenter >> filterInputPresenter [

	^ filterInput
]

{ #category : #private }
SpFilteringListPresenter >> filterListItems: pattern [

	| filteredItems |
	unfilteredItems ifNil: [ unfilteredItems := list items ].
	pattern ifEmpty: [ 
		list items: unfilteredItems.
		^ self ].
	filteredItems := unfilteredItems select: [ :item | itemFilterBlock value: (list display value: item) value: pattern ].
	list items: filteredItems
]

{ #category : #initialization }
SpFilteringListPresenter >> initializePresenters [

	filterInput := self newTextInput placeholder: 'Filter...'; yourself.
	list := self newList.
	self matchSubstring.

]

{ #category : #private }
SpFilteringListPresenter >> itemFilter [

	^ itemFilterBlock
]

{ #category : #api }
SpFilteringListPresenter >> itemFilter: aBlock [

	itemFilterBlock := aBlock
]

{ #category : #api }
SpFilteringListPresenter >> items [

	^ list items
]

{ #category : #api }
SpFilteringListPresenter >> items: aCollection [

	list items: aCollection
]

{ #category : #api }
SpFilteringListPresenter >> listPresenter [

	^ list
]

{ #category : #initialization }
SpFilteringListPresenter >> matchBeginOfString [

	itemFilterBlock := [ :each :pattern | each asLowercase beginsWith: pattern asLowercase ]
]

{ #category : #initialization }
SpFilteringListPresenter >> matchSubstring [

	itemFilterBlock := [ :each :pattern | each asLowercase includesSubstring: pattern asLowercase ]
]
