"
I am a presenter that has a list and a text input for filtering the elements on the list.

The list items are filtered based on what the `display` method of the list returns. In other words, what you see is what is used to filter.

I have two predefined filter methods: `self enableItemBeginsWithFilter` and `self enableItemSubstringFilter`. You can set your own method be calling `self itemFilter: aBlock` with a block that has two parameters: the item and the pattern. See the definitions of the above methods for details.

I have two subwidgets:
- A List (`SpListPresenter`) that has the items.
- A Text Input Field (`SpTextInputFieldPresenter`) for entering the filter text.
"
Class {
	#name : 'SpFilteringListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'unfilteredItems',
		'listPresenter',
		'filterInputPresenter',
		'itemFilterBlock'
	],
	#category : 'Spec2-CommonWidgets-Core',
	#package : 'Spec2-CommonWidgets',
	#tag : 'Core'
}

{ #category : 'specs' }
SpFilteringListPresenter class >> bottomLayout [

	^ SpBoxLayout newTopToBottom
		  add: #listPresenter;
		  add: #filterInputPresenter expand: false;
		  yourself
]

{ #category : 'layout' }
SpFilteringListPresenter class >> defaultLayout [

	^ self bottomLayout
]

{ #category : 'specs' }
SpFilteringListPresenter class >> topLayout [

	^ SpBoxLayout newTopToBottom
		  add: #filterInputPresenter expand: false;
		  add: #listPresenter;
		  yourself
]

{ #category : 'api - actions' }
SpFilteringListPresenter >> actions [

	^ listPresenter actions
]

{ #category : 'api - actions' }
SpFilteringListPresenter >> actions: aCommandGroup [
	
	listPresenter actions: aCommandGroup
]

{ #category : 'api' }
SpFilteringListPresenter >> applyFilter: aString [

	self filterInputPresenter text: aString
]

{ #category : 'api' }
SpFilteringListPresenter >> beMultipleSelection [

	listPresenter beMultipleSelection
]

{ #category : 'api' }
SpFilteringListPresenter >> beSingleSelection [

	listPresenter beSingleSelection
]

{ #category : 'initialization' }
SpFilteringListPresenter >> connectPresenters [

	filterInputPresenter whenTextChangedDo: [ :text | self filterListItems: text ]
]

{ #category : 'api' }
SpFilteringListPresenter >> contextMenu: aValuable [
 
	self listPresenter contextMenu: aValuable
]

{ #category : 'transmission' }
SpFilteringListPresenter >> defaultInputPort [

	^ self inputItemsPort
]

{ #category : 'transmission' }
SpFilteringListPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : 'api' }
SpFilteringListPresenter >> display [ 

	^ self listPresenter display
]

{ #category : 'api' }
SpFilteringListPresenter >> display: aBlock [

	self listPresenter display: aBlock
]

{ #category : 'api' }
SpFilteringListPresenter >> displayIcon: aBlock [

	self listPresenter displayIcon: aBlock
]

{ #category : 'private - actions' }
SpFilteringListPresenter >> ensureActions [

	^ listPresenter ensureActions
]

{ #category : 'accessing' }
SpFilteringListPresenter >> filterInputPresenter [

	^ filterInputPresenter
]

{ #category : 'private' }
SpFilteringListPresenter >> filterListItems: pattern [
	| filteredItems |
	
	pattern ifEmpty: [ 
		listPresenter items: unfilteredItems.
		^ self ].

	filteredItems := unfilteredItems select: [ :item |
		itemFilterBlock
			value: (self display value: item)
			value: pattern ].

	listPresenter items: filteredItems
]

{ #category : 'api' }
SpFilteringListPresenter >> filterText [

	^  self filterInputPresenter text
]

{ #category : 'api' }
SpFilteringListPresenter >> headerTitle: aString [
	"Set the receiver's header title to aString"

	listPresenter headerTitle: aString
]

{ #category : 'initialization' }
SpFilteringListPresenter >> initializePresenters [
	self addStyle: 'filteringList'.

	filterInputPresenter := self newTextInput
		addStyle: 'flat';
		placeholder: 'Filter...';
		yourself.
	listPresenter := self newListToFilter.
	unfilteredItems := #().
	itemFilterBlock ifNil: [
		self matchSubstring ]
]

{ #category : 'transmission' }
SpFilteringListPresenter >> inputItemsPort [

	^ SpListItemsPort newPresenter: self
]

{ #category : 'private' }
SpFilteringListPresenter >> itemFilter [

	^ itemFilterBlock
]

{ #category : 'api' }
SpFilteringListPresenter >> itemFilter: aBlock [

	itemFilterBlock := aBlock
]

{ #category : 'api' }
SpFilteringListPresenter >> items [

	^ listPresenter items
]

{ #category : 'api' }
SpFilteringListPresenter >> items: aCollection [

	listPresenter items: aCollection.
	unfilteredItems := aCollection.
	self reapplyOrResetFilter
]

{ #category : 'accessing' }
SpFilteringListPresenter >> listPresenter [
	^ listPresenter
]

{ #category : 'initialization' }
SpFilteringListPresenter >> matchBeginOfString [

	itemFilterBlock := [ :each :pattern | 
	              each asLowercase beginsWith: pattern asLowercase ]
]

{ #category : 'initialization' }
SpFilteringListPresenter >> matchSubstring [

	itemFilterBlock := [ :each :pattern | 
		each asLowercase includesSubstring: pattern asLowercase ]
]

{ #category : 'initialization' }
SpFilteringListPresenter >> newListToFilter [
	
	^ self newEasyListView
]

{ #category : 'transmission' }
SpFilteringListPresenter >> outputActivationPort [
	
	^ SpActivationPort newPresenter: self
]

{ #category : 'transmission' }
SpFilteringListPresenter >> outputSelectionPort [
	
	^ SpSelectionPort newPresenter: self
]

{ #category : 'api' }
SpFilteringListPresenter >> reapplyOrResetFilter [

	self filterListItems: self filterText.
	self items ifEmpty: [ self resetFilter ]
]

{ #category : 'api' }
SpFilteringListPresenter >> resetFilter [

	self applyFilter: ''
]

{ #category : 'api' }
SpFilteringListPresenter >> rowPresenterClass: aPresenterClass [
	"Selecting a presenter class will override #display: and #displayIcon: selectors. 
	 NOTICE that the #display: will still be used to filter, so you need to define it 
	 anyway" 

	listPresenter rowPresenterClass: aPresenterClass
]

{ #category : 'api - selection' }
SpFilteringListPresenter >> selectIndex: index [

	^ listPresenter selectIndex: index
]

{ #category : 'api - selection' }
SpFilteringListPresenter >> selectIndex: aNumber scrollToSelection: aBoolean [ 
	
	listPresenter selectIndex: aNumber scrollToSelection: aBoolean
]

{ #category : 'api' }
SpFilteringListPresenter >> selectItem: anObject [
	
	listPresenter selectItem: anObject
]

{ #category : 'selection' }
SpFilteringListPresenter >> selectLast [
	listPresenter selectLast
]

{ #category : 'api' }
SpFilteringListPresenter >> selectedItem [
	
	^ listPresenter selectedItem
]

{ #category : 'accessing' }
SpFilteringListPresenter >> selectedItems [
	"Answer a <Collection> of receiver's selected objects"

	^ listPresenter selectedItems
]

{ #category : 'accessing' }
SpFilteringListPresenter >> sortingBlock: aBlockOrNil [

	listPresenter sortingBlock: aBlockOrNil
]

{ #category : 'api' }
SpFilteringListPresenter >> unfilteredItems [

	^ unfilteredItems
]

{ #category : 'api' }
SpFilteringListPresenter >> unfilteredItems: someItems [

	unfilteredItems := someItems
]

{ #category : 'api - selection' }
SpFilteringListPresenter >> unselectAll [

	listPresenter unselectAll
]

{ #category : 'api' }
SpFilteringListPresenter >> updateItemsKeepingSelection: aCollection [
	
	listPresenter updateItemsKeepingSelection: aCollection.
	unfilteredItems := aCollection.
	self reapplyOrResetFilter
]

{ #category : 'api - events' }
SpFilteringListPresenter >> whenActivatedDo: aBlock [

	listPresenter whenActivatedDo: aBlock	
]

{ #category : 'api - events' }
SpFilteringListPresenter >> whenFilterChangedDo: aBlock [
	filterInputPresenter whenTextChangedDo: aBlock
]

{ #category : 'api - events' }
SpFilteringListPresenter >> whenSelectionChangedDo: aBlock [
 
	listPresenter whenSelectionChangedDo: aBlock
]
