Class {
	#name : #AbstractListPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'selectionMode',
		'multiSelectionHolder',
		'sortingBlockHolder',
		'filteringBlockHolder',
		'autoDeselect',
		'itemFilterBlockHolder',
		'menuHolder',
		'allowToSelect',
		'doubleClickActionHolder',
		'activationBlock',
		'activateOnSingleClick',
		'model',
		'displayBlockValueHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #api }
AbstractListPresenter >> activateOnDoubleClick [
	
	activateOnSingleClick := false
]

{ #category : #api }
AbstractListPresenter >> activateOnSingleClick [
	
	activateOnSingleClick := true
]

{ #category : #testing }
AbstractListPresenter >> activatesOnDoubleClick [
	
	^ activateOnSingleClick not
]

{ #category : #testing }
AbstractListPresenter >> activatesOnSingleClick [
	
	^ activateOnSingleClick
]

{ #category : #api }
AbstractListPresenter >> beMultipleSelection [
	self selectionMode: (SpecMultipleSelectionMode on: self)
]

{ #category : #api }
AbstractListPresenter >> beSingleSelection [
	
	self selectionMode: (SpecSingleSelectionMode on: self)
]

{ #category : #simulation }
AbstractListPresenter >> clickAtIndex: anIndex [

	self selectIndex: anIndex.

	activateOnSingleClick ifFalse: [ ^ self ].
	self doActivateAtIndex: anIndex
]

{ #category : #simulation }
AbstractListPresenter >> clickItem: anInteger [ 
	
	self selectIndex: anInteger
]

{ #category : #initialization }
AbstractListPresenter >> defaultFilteringBlock [ 
	^ [:col | col]
]

{ #category : #initialization }
AbstractListPresenter >> defaultSortingBlock [ 
	^ [:a :b | true]
]

{ #category : #api }
AbstractListPresenter >> displayBlock [
	"Return the one argument block used to wrap your domain specific items.
	The block should return something that can be displayed in a list - like a String or a Text"
	
	^ displayBlockValueHolder value
]

{ #category : #api }
AbstractListPresenter >> displayBlock: aBlock [
	"<api: #block getter:#displayBlock registration: #whenDisplayBlockChanged:>"
	"Set the one argument block used to wrap your domain specific items.
	The block should return something that can be displayed in a list - like a String or a Text"
	
	displayBlockValueHolder value: aBlock
]

{ #category : #private }
AbstractListPresenter >> doActivateAtIndex: anIndex [

	"Activate only if there is an item at that position"
	self model at: anIndex ifAbsent: [ ^ self ].
	
	activationBlock cull: ((SpecSingleSelectionMode on: self)
		basicSelectIndex: anIndex;
		yourself)
]

{ #category : #simulation }
AbstractListPresenter >> doubleClickAtIndex: anIndex [
	self selectIndex: anIndex.
	
	activateOnSingleClick ifTrue: [ ^ self ].
	self doActivateAtIndex: anIndex
]

{ #category : #api }
AbstractListPresenter >> filteringBlock [
	"<api: #inspect>"
	"Return the filtering of the items"
	
	^ filteringBlockHolder value
]

{ #category : #api }
AbstractListPresenter >> filteringBlock: aBlock [
	"<api: #block getter: #filteringBlock registration: #whenFilteringBlockChanged:>"
	"To set the filtering of the items"
	
	filteringBlockHolder value: aBlock
]

{ #category : #private }
AbstractListPresenter >> getSelectionStateFor: anIndex [
	"Return the current state of the item -if selected or not - in a multiple selection list"
	"Answer true if the item at index _anIndex_ is selected"
	
	self flag: 'refactoring in progress'.

	^ multiSelectionHolder indexes
]

{ #category : #initialization }
AbstractListPresenter >> initialize [
	super initialize.

	activationBlock := [ ].
	self items: #().

	self beSingleSelection.
	self activateOnDoubleClick.

	self initializeValueHolders.
	self registerEvents.

	self
		bindKeyCombination: Character space
		toAction: [ self clickOnSelectedItem ]
]

{ #category : #initialization }
AbstractListPresenter >> initializePorts [

	self addOutputPort: SelectionPresenterPort new.
	self addInputPort: ItemsPresenterPort new
]

{ #category : #initialization }
AbstractListPresenter >> initializeValueHolders [
	sortingBlockHolder := self defaultSortingBlock asValueHolder.
	filteringBlockHolder := self defaultFilteringBlock asValueHolder.
	itemFilterBlockHolder := nil asValueHolder.
	doubleClickActionHolder := [  ] asValueHolder.
	displayBlockValueHolder := [ :object | object asStringOrText ] asValueHolder.
	menuHolder := [ :menu :shifted | nil ] asValueHolder.
	allowToSelect := true asValueHolder.
	autoDeselect := true asValueHolder
]

{ #category : #testing }
AbstractListPresenter >> isMultipleSelection [
	
	^ selectionMode isMultipleSelection
]

{ #category : #accessing }
AbstractListPresenter >> itemAt: anInteger [ 
	
	^ self model at: anInteger
]

{ #category : #api }
AbstractListPresenter >> itemBeginsWithFilter [
	self itemFilterBlock: [ :each :pattern | each asLowercase beginsWith: pattern asLowercase ]
]

{ #category : #api }
AbstractListPresenter >> itemFilterBlock [
	^ itemFilterBlockHolder value
]

{ #category : #api }
AbstractListPresenter >> itemFilterBlock: aBlock [
	itemFilterBlockHolder value: aBlock
]

{ #category : #api }
AbstractListPresenter >> itemSubstringFilter [
	self itemFilterBlock: [ :each :pattern | each asLowercase includesSubstring: pattern asLowercase ]
]

{ #category : #api }
AbstractListPresenter >> items: aCollection [
	"Set the items of the list.
	aCollection is a collection of your domain specific items.
	This creates a collection model"
	
	model ifNil: [ 
		model := SpecCollectionListModel on: aCollection.
		^ self ].
	
	model collection: aCollection
]

{ #category : #private }
AbstractListPresenter >> listElementAt: anIndex [
	"Return the item at index _anIndex_"

	^ self model shownItems at: anIndex ifAbsent: [ nil ]
]

{ #category : #private }
AbstractListPresenter >> listElementAt: anIndex ifAbsent: aBlock [	
	"Return the item at index _anIndex_"
	
	^ self listItems at: anIndex ifAbsent: aBlock
]

{ #category : #api }
AbstractListPresenter >> listSize [
	"<api: #inspect>"

	"Return the size of the list"

	^ self model shownItems size
]

{ #category : #api }
AbstractListPresenter >> menu [
	"<api: #inspect>"
	"Return the block used to defined the menu"
	
	^ menuHolder value
]

{ #category : #api }
AbstractListPresenter >> menu: aBlock [
	"<api: #block getter: #menu registration: #whenMenuChanged:>"
	"Set the block used to defined the menu"
	
	menuHolder value: aBlock
]

{ #category : #private }
AbstractListPresenter >> menu: aMenu shifted: aBoolean [
	"Build the menu when you right click on an item"

	"This does not work on multiple selection"

	self flag: #bug.
	self selection selectedItems ifEmpty: [ ^ nil ].
	^ menuHolder value cull: aMenu cull: aBoolean
]

{ #category : #accessing }
AbstractListPresenter >> model [
	
	^ model
]

{ #category : #accessing }
AbstractListPresenter >> model: aModel [
	
	model := aModel
]

{ #category : #initialization }
AbstractListPresenter >> registerEvents [

	selectionMode whenChangedDo: [ :selection | 
		self adapter ifNotNil: #refreshWidgetSelection ].
	displayBlockValueHolder whenChangedDo: [ 
		self adapter ifNotNil: #refreshWidgetList ].
	autoDeselect whenChangedDo: [ :boolean | 
		self changed: #autoDeselect: with: { boolean }].
]

{ #category : #simulation }
AbstractListPresenter >> rightClickAtIndex: anIndex [
	
	self clickItem: anIndex.
	^ self menu: nil shifted: false
]

{ #category : #api }
AbstractListPresenter >> selectIndex: anInteger [ 
	
	self selectionMode selectIndex: anInteger
]

{ #category : #api }
AbstractListPresenter >> selectItem: anItem [ 
	
	self selectionMode selectItem: anItem
]

{ #category : #api }
AbstractListPresenter >> selectedItems [
	"<api: #inspect>"

	"Return all the selected items in the case of a multiple selection list"

	^ self selectedItemsAtIndexes: self selection selectedIndexes
]

{ #category : #private }
AbstractListPresenter >> selectedItemsAtIndexes: aCollectionOfIndex [
	^ aCollectionOfIndex collect: [ :anIndex | self listElementAt: anIndex ]
]

{ #category : #api }
AbstractListPresenter >> selectedItemsSorted [
	"return all the selected items sorted by their index"

	^ self selectedItemsAtIndexes: self selection selectedIndexes sort
]

{ #category : #accessing }
AbstractListPresenter >> selection [
	
	^ selectionMode
]

{ #category : #accessing }
AbstractListPresenter >> selectionMode [
	
	^ selectionMode
]

{ #category : #api }
AbstractListPresenter >> selectionMode: aMode [
	
	selectionMode ifNotNil: [ 
		selectionMode transferSubscriptionsTo: aMode ].
	selectionMode := aMode.
]

{ #category : #api }
AbstractListPresenter >> sortingBlock [
	"<api: #inspect>"
	"Return the ordering of the items"
	
	^ sortingBlockHolder value
]

{ #category : #api }
AbstractListPresenter >> sortingBlock: aBlock [
	"<api: #block getter: #sortingBlock registration: #whenSortingBlockChanged:>"
	"To set the ordering of the items"
	
	sortingBlockHolder value: aBlock
]

{ #category : #api }
AbstractListPresenter >> unselectAll [
	
	self selection unselectAll
]

{ #category : #api }
AbstractListPresenter >> unselectIndex: anInteger [ 
	
	self selection unselectIndex: anInteger
]

{ #category : #api }
AbstractListPresenter >> unselectItem: anInteger [ 
	
	self selection unselectItem: anInteger
]

{ #category : #'api-events' }
AbstractListPresenter >> whenActivatedDo: aBlockClosure [ 
	
	activationBlock := aBlockClosure.
]

{ #category : #'api-events' }
AbstractListPresenter >> whenModelChangedDo: aBlock [

	model whenChangedDo: aBlock
]

{ #category : #'api-events' }
AbstractListPresenter >> whenSelectionChangedDo: aBlock [
	"Subscribe to changes in selection.
	This method works for all selection modes (single, multiple and no selection).
	The block used as argument will be sent an optional argument with the selection object."

	self selection whenChangedDo: aBlock
]

{ #category : #private }
AbstractListPresenter >> wrapItem: anObject [ 
	"Return the item _anObject_ wrapped"

	^ displayBlockValueHolder value cull: anObject 
]

{ #category : #private }
AbstractListPresenter >> wrapItem: anObject index: index [
	"Return the item _anObject_ wrapped"

	^ displayBlockValueHolder value cull: anObject cull: index
]
