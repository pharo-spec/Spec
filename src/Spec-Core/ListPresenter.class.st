"
A ListPresenter is an applicative presenter which handle a basic list.
See AbstractWidgetPresenter

self example
self example2
self example3

You can also have a look at ExampleListPresenter >> exampleRegisteredColor and ListSelectionPresenter for more examples.

I provide the following variables and their accessors
- backgroundColorBlock should convert an item in the color in the background in the line of this item.
- displayBlock should convert an item in something that can be displayed in a list, use asStringOrText by default.
- filteringBlock should convert an item in a boolean representing if the item will be displayed, initialize with self defaultFilteringBlock.
- multiSelection is a boolean representing if several items can be selected in the same time, it have shortcut beMultipleSelection and beSingleSelection.
- sortingBlock should convert two items in a boolean representing if the first item must be place before the second, initialize with self defaultSortingBlock.

Blocks should be set before items.

I provide the following methods
- items: to set the list with the elements of the collection in parameter
- getIndex is the getter of the index of the selected item or the last selected item.
- getList is the getter of the list.
- listSize is the number of items.


todo
- allowToSelect
- autoDeselect
- menu
- listItems
- clickOnSelectedItem
- getSelectionStateFor:
- listElementAt:ifAbsent:
- refresh ...
- select ... , setSelected ...
- updateList

"
Class {
	#name : #ListPresenter,
	#superclass : #AbstractListPresenter,
	#instVars : [
		'backgroundColorBlock'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #specs }
ListPresenter class >> adapterName [

	^ #ListAdapter
]

{ #category : #example }
ListPresenter class >> example [
	<sampleInstance>
	^ self new
		items: Smalltalk globals allClasses;
		openWithSpec;
		yourself
]

{ #category : #specs }
ListPresenter class >> title [

	^ 'List'
]

{ #category : #api }
ListPresenter >> allowToSelect [
	"Return whether the list items can be selected or not"
	
	self deprecated: 'Should not use. Use #selectionMode instead'.
	^ allowToSelect value
]

{ #category : #api }
ListPresenter >> allowToSelect: aBoolean [
	"Set if the list items can be selected or not"

	self deprecated: 'Should not use. Use #selectionMode: instead'.
	allowToSelect value: aBoolean.
	aBoolean 
		ifFalse: [ self resetSelection ].
]

{ #category : #api }
ListPresenter >> autoDeselect [
	"Return whether the list items can be selected if it's already the selected item"
	"If true, clicking again on the selected item will unselect it"

	self deprecated: 'Should not use. This feature is not supported anymore'.	
	^ autoDeselect value
]

{ #category : #api }
ListPresenter >> autoDeselect: aBoolean [
	"Set if the list items can be selected again"

	self deprecated: 'Should not use. This feature is not supported anymore'.
	autoDeselect value: aBoolean
]

{ #category : #api }
ListPresenter >> backgroundColorBlock [
	"Return the block use to compute the background color for each item"

	self deprecated: 'Should not use. This feature is not supported anymore. This feature depends on the theme'.
	^ backgroundColorBlock value
]

{ #category : #api }
ListPresenter >> backgroundColorBlock: aBlock [
	"Set the block used to compute an item background"

	self deprecated: 'Should not use. This feature is not supported anymore. This feature depends on the theme'.
	backgroundColorBlock value: aBlock
]

{ #category : #api }
ListPresenter >> backgroundColorFor: anItem at: index [

	self deprecated: 'Should not use. This feature is not supported anymore. This feature depends on the theme'.
	^ self backgroundColorBlock cull: anItem cull: index
]

{ #category : #private }
ListPresenter >> clickOnSelectedItem [
	| item |
	
	item := self selectedItem.
	(item notNil and: [ item respondsTo: #click ])
		ifTrue: [ ^ item click ]
		ifFalse: [ ^ false ]
]

{ #category : #api }
ListPresenter >> displayBlock [
	"<api: #inspect>"
	"Return the one argument block used to wrap your domain specific items.
	The block should return something that can be displayed in a list - like a String or a Text"
	
	^ wrapBlockHolder value
]

{ #category : #api }
ListPresenter >> displayBlock: aBlock [
	"<api: #block getter:#displayBlock registration: #whenDisplayBlockChanged:>"
	"Set the one argument block used to wrap your domain specific items.
	The block should return something that can be displayed in a list - like a String or a Text"
	
	wrapBlockHolder value: aBlock
]

{ #category : #api }
ListPresenter >> filteringBlock [
	"<api: #inspect>"
	"Return the filtering of the items"
	
	^ filteringBlockHolder value
]

{ #category : #api }
ListPresenter >> filteringBlock: aBlock [
	"<api: #block getter: #filteringBlock registration: #whenFilteringBlockChanged:>"
	"To set the filtering of the items"
	
	filteringBlockHolder value: aBlock
]

{ #category : #api }
ListPresenter >> getIndex [

	^ self selection selectedIndex
]

{ #category : #api }
ListPresenter >> getList [

	^ listHolder value
]

{ #category : #private }
ListPresenter >> getSelectionStateFor: anIndex [
	"Return the current state of the item -if selected or not - in a multiple selection list"
	"Answer true if the item at index _anIndex_ is selected"
	
	self flag: 'refactoring in progress'.

	^ multiSelectionHolder indexes
]

{ #category : #initialization }
ListPresenter >> initializePorts [

	self addOutputPort: SelectionPresenterPort new.
	self addInputPort: ItemsPresenterPort new
]

{ #category : #api }
ListPresenter >> itemBeginsWithFilter [
	self itemFilterBlock: [ :each :pattern | each asLowercase beginsWith: pattern asLowercase ]
]

{ #category : #api }
ListPresenter >> itemFilterBlock [
	^ itemFilterBlockHolder value
]

{ #category : #api }
ListPresenter >> itemFilterBlock: aBlock [
	itemFilterBlockHolder value: aBlock
]

{ #category : #api }
ListPresenter >> itemSubstringFilter [
	self itemFilterBlock: [ :each :pattern | each asLowercase includesSubstring: pattern asLowercase ]
]

{ #category : #private }
ListPresenter >> listElementAt: anIndex [
	"Return the item at index _anIndex_"
	
	^ self listItems at: anIndex ifAbsent: [ nil ]
]

{ #category : #private }
ListPresenter >> listElementAt: anIndex ifAbsent: aBlock [	
	"Return the item at index _anIndex_"
	
	^ self listItems at: anIndex ifAbsent: aBlock
]

{ #category : #api }
ListPresenter >> listItems [
	"<api: #inspect>"
	"Return the items of the list. They are your domain specific items"
	
	^ listItemsCache ifNil: [ listItemsCache :=  filteringBlockHolder value value: listHolder value ]
	
]

{ #category : #api }
ListPresenter >> listSize [
	"<api: #inspect>"
	"Return the size of the list"
	
	^ self listItems size
]

{ #category : #api }
ListPresenter >> menu [
	"<api: #inspect>"
	"Return the block used to defined the menu"
	
	^ menuHolder value
]

{ #category : #api }
ListPresenter >> menu: aBlock [
	"<api: #block getter: #menu registration: #whenMenuChanged:>"
	"Set the block used to defined the menu"
	
	menuHolder value: aBlock
]

{ #category : #private }
ListPresenter >> menu: aMenu shifted: aBoolean [
	"Build the menu when you right click on an item"

	"This does not work on multiple selection"
	self flag: #bug.
	self selectedItem ifNil: [ ^ nil ].

	^ menuHolder value cull: aMenu cull: aBoolean
]

{ #category : #private }
ListPresenter >> prepareForFilteredDataSourceWith: items [

	listHolder := items asValueHolder.
	listHolder whenChangedDo: [ self refreshListItems ].
	listItemsCache := nil
]

{ #category : #api }
ListPresenter >> resetFilteringBlock [
	"<api: #do>"
	"Reset the filtering block with the default value which consists in showing everything"

	filteringBlockHolder value: self defaultFilteringBlock
]

{ #category : #private }
ListPresenter >> resetListSelection [
	"Reset the selection manager for multiple selection lists"
	
	multiSelectionHolder reset
]

{ #category : #api }
ListPresenter >> resetSelection [
	"<api: #do>"
	"Unselect every items"

	selectionHolder reset.
	multiSelectionHolder reset
]

{ #category : #api }
ListPresenter >> resetSortingBlock [
	"<api: #do>"
	"Reset the sortering block with the default value which consists in not sorting"

	sortingBlockHolder value: self defaultSortingBlock
]

{ #category : #api }
ListPresenter >> selectAll [
	self listItems ifEmpty: [ ^ self ].

	self setIndexes: (1 to: self listItems size).
	self changed: #listElementAt:
]

{ #category : #private }
ListPresenter >> setSelectionStateFor: anIndex at: aBoolean [
	"Set the selection state of the item at index _anIndex_ in the case of multiple selection list"
	self flag: 'refactoring in progress'.
	(self allowToSelect and: [ self multiSelection ]) ifFalse: [ ^ self ].

	^ self setIndexes: (self selectedIndexes value copyWith: anIndex) asSet asOrderedCollection
]

{ #category : #api }
ListPresenter >> sortingBlock [
	"<api: #inspect>"
	"Return the ordering of the items"
	
	^ sortingBlockHolder value
]

{ #category : #api }
ListPresenter >> sortingBlock: aBlock [
	"<api: #block getter: #sortingBlock registration: #whenSortingBlockChanged:>"
	"To set the ordering of the items"
	
	sortingBlockHolder value: aBlock
]

{ #category : #api }
ListPresenter >> updateList [
	"<api: #do>"
	"Refresh the list"
	
	self changed: #listElementAt:.
	self resetSelection
]

{ #category : #'api-events' }
ListPresenter >> whenAllowToSelectChanged: aBlock [
	"Set a block to value when the value of allowToSelect has changed"
	
	allowToSelect whenChangedDo: aBlock
]

{ #category : #'api-events' }
ListPresenter >> whenAutoDeselectChanged: aBlock [
	"Set a block to value when the value of autoDeselect has changed"
	
	autoDeselect whenChangedDo: aBlock
]

{ #category : #'api-events' }
ListPresenter >> whenBackgroundColorBlockChanged: aBlock [
	"Set a block to value when the backgroundColorBlock has changed"
	
	backgroundColorBlock whenChangedDo: aBlock
]

{ #category : #'api-events' }
ListPresenter >> whenDisplayBlockChanged: aBlock [
	"Set a block to value when the filtering block has changed"
	
	wrapBlockHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
ListPresenter >> whenFilteringBlockChanged: aBlock [
	"Set a block to value when the filtering block block has changed"
	
	filteringBlockHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
ListPresenter >> whenMenuChanged: aBlock [
	"Set a block to value when the menu block has changed"
	
	menuHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
ListPresenter >> whenSortingBlockChanged: aBlock [
	"Set a block to value when the sorting block has changed"
	
	sortingBlockHolder whenChangedDo: aBlock
]

{ #category : #private }
ListPresenter >> wrapItem: anObject [ 
	"Return the item _anObject_ wrapped"

	^ wrapBlockHolder value cull: anObject 
]

{ #category : #private }
ListPresenter >> wrapItem: anObject index: index [
	"Return the item _anObject_ wrapped"

	^ wrapBlockHolder value cull: anObject cull: index
]
