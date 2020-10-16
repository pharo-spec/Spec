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
		'itemFilter',
		'unfilteredItems',
		'list',
		'filterInput'
	],
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #specs }
SpFilteringListPresenter class >> bottomLayout [

	^ SpBoxLayout newVertical
		  add: #list;
		  add: #filterInputPresenter expand: false;
		  yourself
]

{ #category : #specs }
SpFilteringListPresenter class >> defaultSpec [

	^ self bottomLayout
]

{ #category : #specs }
SpFilteringListPresenter class >> topLayout [

	^ SpBoxLayout newVertical
		  add: #filterInputPresenter expand: false;
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
SpFilteringListPresenter >> display: aBlock [

	self listPresenter display: aBlock
]

{ #category : #api }
SpFilteringListPresenter >> displayIcon: aBlock [

	self listPresenter displayIcon: aBlock
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
	filteredItems := unfilteredItems select: [ :item | 
		                 itemFilter
			                 value: (list display value: item)
			                 value: pattern ].
	list items: filteredItems
]

{ #category : #api }
SpFilteringListPresenter >> filterText [

	^  self filterInputPresenter text
]

{ #category : #initialization }
SpFilteringListPresenter >> initializePresenters [

	filterInput := self newTextInput placeholder: 'Filter...'; yourself.
	list := self newList.
	self matchSubstring
]

{ #category : #private }
SpFilteringListPresenter >> itemFilter [

	^ itemFilter
]

{ #category : #api }
SpFilteringListPresenter >> itemFilter: aBlock [

	itemFilter := aBlock
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

	itemFilter := [ :each :pattern | 
	              each asLowercase beginsWith: pattern asLowercase ]
]

{ #category : #initialization }
SpFilteringListPresenter >> matchSubstring [

	itemFilter := [ :each :pattern | 
		each 
			includesSubstring: pattern asLowercase 
			caseSensitive: false ]
]
