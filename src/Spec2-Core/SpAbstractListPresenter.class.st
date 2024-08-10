"
A base for list presenters, it defines basic functionality common to all lists.
"
Class {
	#name : 'SpAbstractListPresenter',
	#superclass : 'SpAbstractWidgetPresenter',
	#traits : 'SpTHaveWrappingScrollBars + SpTContextMenu + SpTAlignableColumn + SpTSelectionMode',
	#classTraits : 'SpTHaveWrappingScrollBars classTrait + SpTContextMenu classTrait + SpTAlignableColumn classTrait + SpTSelectionMode classTrait',
	#instVars : [
		'#activationBlock',
		'#activateOnSingleClick',
		'#model',
		'#verticalAlignment'
	],
	#category : 'Spec2-Core-Widgets-Table',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Table'
}

{ #category : 'documentation' }
SpAbstractListPresenter class >> documentSections [

	^ OrderedDictionary newFromPairs: {
			  'Examples'.
			  (self class methods select: [ :method | method protocolName = self documentExamplesProtocol ]).
			  'API Methods'.
			  (self methods select: [ :method | method protocolName = #api ]).
			  'API Selection Methods'.
			  (self methods select: [ :method | method protocolName = #'api - selection' ]).
			  'Testing Methods'.
			  (self methods select: [ :method | method protocolName = #testing ]).
			  'Events'.
			  (self methods select: [ :method | method protocolName = #'api - events' ]) }
]

{ #category : 'testing' }
SpAbstractListPresenter class >> isAbstract [

	^ super isAbstract or: [ self = SpAbstractListPresenter ]	
]

{ #category : 'api' }
SpAbstractListPresenter >> activateOnDoubleClick [
	"Configure the list to trigger activation on double click.
	 An element on a list can be 'activated', meaning it will trigger an event to execute an 
	 action on it. An activation is different than a selection (one can 'select' an element without 
	 activating it).
	 See `SpAbstractListPresenter>>#whenActivatedDo:`"
	
	activateOnSingleClick := false
]

{ #category : 'api' }
SpAbstractListPresenter >> activateOnSingleClick [
	"Configure the list to trigger activation on single click.
	 An element on a list can be 'activated', meaning it will trigger an event to execute an 
	 action on it. An activation is different than a selection (one can 'select' an element without 
	 activating it).
	 See `SpAbstractListPresenter>>#whenActivatedDo:`"
	
	activateOnSingleClick := true
]

{ #category : 'api' }
SpAbstractListPresenter >> beMultipleSelection [
	"Enable multiple selection."

	self selectionMode: (SpMultipleSelectionMode on: self)
]

{ #category : 'api' }
SpAbstractListPresenter >> beSingleSelection [
	"Enable single selection (this is the default)."
	
	self selectionMode: (SpSingleSelectionMode on: self)
]

{ #category : 'simulation' }
SpAbstractListPresenter >> clickAtIndex: anIndex [

	self selectIndex: anIndex.

	activateOnSingleClick ifFalse: [ ^ self ].
	self doActivateAtIndex: anIndex
]

{ #category : 'simulation' }
SpAbstractListPresenter >> clickItem: anInteger [ 
	
	self selectIndex: anInteger
]

{ #category : 'private' }
SpAbstractListPresenter >> disableActivationDuring: aBlock [
	| oldActivate |
	
	oldActivate := activationBlock.
	activationBlock := [ ].
	aBlock ensure: [ 
		activationBlock := oldActivate ]
]

{ #category : 'private' }
SpAbstractListPresenter >> doActivateAtIndex: anIndex [

	"Activate only if there is an item at that position"
	activationBlock  ifNil: [ ^ self ].
	self model at: anIndex ifAbsent: [ ^ self ].
	
	activationBlock cull: ((SpSingleSelectionMode on: self)
		basicSelectIndex: anIndex;
		yourself)
]

{ #category : 'simulation' }
SpAbstractListPresenter >> doubleClickAtIndex: anIndex [
	self selectIndex: anIndex.
	
	activateOnSingleClick ifTrue: [ ^ self ].
	self doActivateAtIndex: anIndex
]

{ #category : 'initialization' }
SpAbstractListPresenter >> initialize [

	super initialize.
	self initializeTHaveWrappingScrollBars.
	
	activationBlock := [ ].
	verticalAlignment := SpVerticalAlignment new.

	self withScrollBars.
	self model: 	self newEmptyModel.

	self beSingleSelection.
	self activateOnDoubleClick.

	self registerActions.
	self registerEvents
]

{ #category : 'testing' }
SpAbstractListPresenter >> isActiveOnDoubleClick [
	"Answer true if activation event is triggered on double click"

	^ activateOnSingleClick not
]

{ #category : 'testing' }
SpAbstractListPresenter >> isActiveOnSingleClick [
	"Answer true if activation event is triggered on single click"

	^ activateOnSingleClick
]

{ #category : 'testing' }
SpAbstractListPresenter >> isMultipleSelection [
	"Answer true if list accepts multiple selection"
	
	^ selectionMode isMultipleSelection
]

{ #category : 'private' }
SpAbstractListPresenter >> itemAt: index [ 
	"If there is an adapter the widget items indexes can be different thant the model items indexes, 
	e.g. when the sort by a column is activated. In this case, ask the adapter to get the element 
	displayed at index."

	^ self adapter 
		ifNotNil: [ :anAdapter | anAdapter elementAt: index ]
		ifNil: [ self model at: index ]
]

{ #category : 'private' }
SpAbstractListPresenter >> itemAtPath: anArray [
	"This is to provide polymorphism with SpTreeTablePresentrer"

	^ self itemAt: anArray first
]

{ #category : 'api' }
SpAbstractListPresenter >> items [
	"Answer the items of the list"
	
	^ self model collection
]

{ #category : 'api' }
SpAbstractListPresenter >> items: aSequenceableCollection [
	"Set the items of the list.
	`aSequenceableCollection` is a collection of your domain specific items.
	This resets the collection model and unselects any previously selected item."
	
	self unselectAll.	
	model collection: aSequenceableCollection
]

{ #category : 'private' }
SpAbstractListPresenter >> itemsAt: aCollectionOfIndex [
	^ aCollectionOfIndex collect: [ :anIndex | self itemAt: anIndex ]
]

{ #category : 'api' }
SpAbstractListPresenter >> listSize [
	"Return the size of the item list contained in model (see `SpAbstractListPresenter>>#model`)"

	self flag: #TODO. "Maybe this should be called #itemsSize? (since we set #items: and not #list: )"
	^ self model size
]

{ #category : 'api' }
SpAbstractListPresenter >> model [
	"Answer the model for this list. 
	 It is tipically, an instance of `SpCollectionListModel`."
	
	^ model
]

{ #category : 'api' }
SpAbstractListPresenter >> model: aModel [
	"Sets the model used to feed the list presenter with elements of the list. 
	 It is tipically an instance of `SpCollectionListModel`."
	
	model := aModel.
	model whenChangedDo: [ 
		self withAdapterDo: [ :anAdapter | anAdapter refreshList ] ]
]

{ #category : 'private' }
SpAbstractListPresenter >> newEmptyModel [

	^ SpCollectionListModel on: #()
]

{ #category : 'api' }
SpAbstractListPresenter >> refresh [
	"Forces a refresh of the list. 
	 This is useful when some model contents has changed, but we do not want to reset the whole list 
	 (and losing selections with it)"

	self withAdapterDo: [ :anAdapter | anAdapter refreshList ]
]

{ #category : 'initialization' }
SpAbstractListPresenter >> registerActions [

	self addActionWith: [ :action | action 
		beShortcutOnly;
		shortcut: $t actionModifier;
		action: [ self showContextMenu ] ]
]

{ #category : 'initialization' }
SpAbstractListPresenter >> registerEvents [

	self whenSelectionModeChangedDo: [ :selection | 
		self withAdapterDo: [ :anAdapter | anAdapter refreshWidgetSelection ] ].
	self whenMenuChangedDo: [ 
		self withAdapterDo: [ :anAdapter | anAdapter updateMenu ] ]
]

{ #category : 'api' }
SpAbstractListPresenter >> sortingBlock [
	"Answer the sorting block defined to sort the model list.
	 `aBlock` is a two arguments block that answer a boolean (e.g. `[ :a :b | a < b ]`) 
	 or a `SortFunction`"

	self flag: #TODO. "Find a better name than 'sortingBlock'"
	^ self model sortingBlock
]

{ #category : 'api' }
SpAbstractListPresenter >> sortingBlock: aBlock [
	"Set sorting block to sort the model list.
	 `aBlock` is a two arguments block that answer a boolean (e.g. `[ :a :b | a < b ]`) 
	 or a `SortFunction`"

	self model sortingBlock: aBlock
]

{ #category : 'api' }
SpAbstractListPresenter >> updateItemsKeepingSelection: aCollection [
	"Update list items keeping current selection. 
	 WARNING: aCollection must includes the elements selected."
	
	self disableActivationDuring: [ 
		| items |
		items := self selection selectedItems.
		self items: aCollection.
		self selectItems: items ]
]

{ #category : 'accessing' }
SpAbstractListPresenter >> verticalAlignment [

	^ verticalAlignment
]

{ #category : 'api - events' }
SpAbstractListPresenter >> whenActivatedDo: aBlock [
	"Inform when an element has been 'activated'. 
	 `aBlock` receives one argument (a selection object, see `SpAbstractSelectionMode`)"
	
	activationBlock := aBlock
]

{ #category : 'api - events' }
SpAbstractListPresenter >> whenModelChangedDo: aBlock [
	"Inform when model has been changed (see `SpAbstractListPresenter>>#model:`. 
	 `aBlock` receive 3 optional arguments: 
	 - new value 
	 - old value 
	 - announcement triggered"

	model whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractListPresenter >> whenSearchEnabledChangedDo: aBlock [
	"Inform when search enabled/disabled has changed.
	`aBlock` receives zero arguments."
	
	self property: #searchEnabled whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractListPresenter >> whenSortingBlockChangedDo: aBlock [
	"Inform when sorting block changed. 
	 `aBlock` receives one argument with the new sort function (or block with two arguments).
	 See `SpAbstractListPresenter>>#sortingBlock`"

	self model whenSortingBlockChangedDo: aBlock
]
