Class {
	#name : #SpAbstractListPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#traits : 'SpTHaveWrappingScrollBars + SpTContextMenu',
	#classTraits : 'SpTHaveWrappingScrollBars classTrait + SpTContextMenu classTrait',
	#instVars : [
		'#selectionMode',
		'#activationBlock',
		'#activateOnSingleClick',
		'#model',
		'#itemFilter => SpObservableSlot',
		'#verticalAlignment'
	],
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #api }
SpAbstractListPresenter >> activateOnDoubleClick [
	
	activateOnSingleClick := false
]

{ #category : #api }
SpAbstractListPresenter >> activateOnSingleClick [
	
	activateOnSingleClick := true
]

{ #category : #testing }
SpAbstractListPresenter >> activatesOnDoubleClick [
	
	^ activateOnSingleClick not
]

{ #category : #testing }
SpAbstractListPresenter >> activatesOnSingleClick [
	
	^ activateOnSingleClick
]

{ #category : #api }
SpAbstractListPresenter >> beMultipleSelection [
	self selectionMode: (SpMultipleSelectionMode on: self)
]

{ #category : #api }
SpAbstractListPresenter >> beSingleSelection [
	
	self selectionMode: (SpSingleSelectionMode on: self)
]

{ #category : #simulation }
SpAbstractListPresenter >> clickAtIndex: anIndex [

	self selectIndex: anIndex.

	activateOnSingleClick ifFalse: [ ^ self ].
	self doActivateAtIndex: anIndex
]

{ #category : #simulation }
SpAbstractListPresenter >> clickItem: anInteger [ 
	
	self selectIndex: anInteger
]

{ #category : #api }
SpAbstractListPresenter >> disableFilter [
	self itemFilter: nil
]

{ #category : #private }
SpAbstractListPresenter >> doActivateAtIndex: anIndex [

	"Activate only if there is an item at that position"
	self model at: anIndex ifAbsent: [ ^ self ].
	
	activationBlock cull: ((SpSingleSelectionMode on: self)
		basicSelectIndex: anIndex;
		yourself)
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> doubleClickAction: aBlockClosure [ 
	
	self
		deprecated: 'Use whenActivatedDo: instead'
		transformWith: '`@receiver whenActivatedDo: `@argument'
						-> '`@receiver doubleClickAction: `@argument'.
	
	self whenActivatedDo: [ :sel | aBlockClosure value: sel selectedItem]
]

{ #category : #simulation }
SpAbstractListPresenter >> doubleClickAtIndex: anIndex [
	self selectIndex: anIndex.
	
	activateOnSingleClick ifTrue: [ ^ self ].
	self doActivateAtIndex: anIndex
]

{ #category : #api }
SpAbstractListPresenter >> enableItemBeginsWithFilter [
	self itemFilter: [ :each :pattern | each asLowercase beginsWith: pattern asLowercase ]
]

{ #category : #api }
SpAbstractListPresenter >> enableItemSubstringFilter [
	self itemFilter: [ :each :pattern | each asLowercase includesSubstring: pattern asLowercase ]
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> filteringBlock [
	self
		deprecated: 'This feature is now removed from Spec 2. If the visible elements of the list need to be changed, it''s the users of the lists that should manage it and update the list of items of the list.'.
	^ nil
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> filteringBlock: aBlock [
	self
		deprecated: 'This feature is now removed from Spec 2. If the visible elements of the list need to be changed, it''s the users of the lists that should manage it and update the list of items of the list.'
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> getSelectionStateFor: anIndex [
	self deprecated: 'This method from the old API will be removed.' transformWith: '`@receiver getSelectionStateFor: `@statements' -> '`@receiver selection selectedIndexes includes: `@statements'.

	^ self selection selectedIndexes includes: anIndex
]

{ #category : #initialization }
SpAbstractListPresenter >> initialize [

	super initialize.
	
	activationBlock := [ ].
	verticalAlignment := SpVerticalAlignment new.

	self withScrollBars.
	self model: 	self newEmptyModel.

	self beSingleSelection.
	self activateOnDoubleClick.

	self registerEvents
]

{ #category : #testing }
SpAbstractListPresenter >> isMultipleSelection [
	
	^ selectionMode isMultipleSelection
]

{ #category : #accessing }
SpAbstractListPresenter >> itemAt: anInteger [ 
	
	^ self model at: anInteger
]

{ #category : #private }
SpAbstractListPresenter >> itemAtPath: anArray [
	"This is to provide polymorphism with SpTreeTablePresentrer"

	^ self listElementAt: anArray first
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> itemBeginsWithFilter [
	self deprecated: 'Use #enableItemBeginsWithFilter instead' transformWith: '`@receiver itemBeginsWithFilter' -> '`@receiver enableItemBeginsWithFilter'.
	self enableItemBeginsWithFilter
]

{ #category : #api }
SpAbstractListPresenter >> itemFilter [
	^ itemFilter
]

{ #category : #api }
SpAbstractListPresenter >> itemFilter: aBlock [
	"This block will be used with the search field of the list to filter it with the user input dynamically."

	itemFilter := aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> itemFilterBlock [
	self deprecated: 'Use #itemFilter instead' transformWith: '`@receiver itemFilterBlock' -> '`@receiver itemFilter'.
	^ self itemFilter
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> itemFilterBlock: aBlock [
	self deprecated: 'Use #itemFilter: instead' transformWith: '`@receiver itemFilterBlock: `@statements1' -> '`@receiver itemFilter: `@statements1'.
	^ self itemFilter: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> itemSubstringFilter [
	self deprecated: 'Use #enableItemSubstringFilter instead' transformWith: '`@receiver itemSubstringFilter' -> '`@receiver enableItemSubstringFilter'.
	self enableItemSubstringFilter
]

{ #category : #private }
SpAbstractListPresenter >> items [
	
	^ self model collection
]

{ #category : #api }
SpAbstractListPresenter >> items: aCollection [
	"Set the items of the list.
	aCollection is a collection of your domain specific items.
	This creates a collection model"
	
	model collection: aCollection
]

{ #category : #private }
SpAbstractListPresenter >> listElementAt: anIndex [
	"Return the item at index _anIndex_"

	^ self model at: anIndex ifAbsent: [ nil ]
]

{ #category : #private }
SpAbstractListPresenter >> listElementAt: anIndex ifAbsent: aBlock [	
	"Return the item at index _anIndex_"
	
	^ self listItems at: anIndex ifAbsent: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> listItems [
	
	self
		deprecated: 'Please use the #model instead'
		transformWith: '`@receiver listItems' 
						-> '`@receiver model items'.	
	^ self model items
]

{ #category : #api }
SpAbstractListPresenter >> listSize [
	"Return the size of the list"

	^ self model size
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> menu [
	"Return the block used to defined the menu"
	self 
		deprecated: 'Use #contextMenu instead.' 
		transformWith: '`@receiver menu' 
						-> '`@receiver contextMenu'.
	
	^ self contextMenu
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> menu: aBlock [
	"Set the block used to defined the menu"

	self
		deprecated:
			'Use #contextMenu: instead. The old way to create a MenuPresenter was this method taking a MenuMorph as parameter. This will not work with other backend and will be totally removed in Pharo7. Now you should use #contextMenu takin a MenuPresenter (or a block returning a menu presenter) as parameter.'
		on: '2019-03-07'
		in: #Pharo8.
	self
		contextMenu: [ aBlock
				cull:
					(MenuMorph new
						defaultTarget: self;
						yourself)
				cull: false ]
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> menu: aBlock shifted: aBoolean [
	self
		deprecated:
			'Use #contextMenu: instead. The old way to create a MenuPresenter was this method taking a MenuMorph as parameter. This will not work with other backend and will be totally removed in Pharo7. Now you should use #contextMenu takin a MenuPresenter (or a block returning a menu presenter) as parameter.'
		on: '2019-03-07'
		in: #Pharo8.
	self
		contextMenu: [ aBlock
				cull:
					(MenuMorph new
						defaultTarget: self;
						yourself)
				cull: true ]
]

{ #category : #accessing }
SpAbstractListPresenter >> model [
	
	^ model
]

{ #category : #accessing }
SpAbstractListPresenter >> model: aModel [
	
	model := aModel.
	model whenChangedDo: [ 
		self withAdapterDo: [ :anAdapter | anAdapter refreshList ] ]
]

{ #category : #private }
SpAbstractListPresenter >> newEmptyModel [

	^ SpCollectionListModel on: #()
]

{ #category : #initialization }
SpAbstractListPresenter >> registerEvents [

	self whenSelectionModeChangedDo: [ :selection | 
		self withAdapterDo: [ :anAdapter | anAdapter refreshWidgetSelection ] ].
	self whenMenuChangedDo: [ 
		self withAdapterDo: [ :anAdapter | anAdapter updateMenu ] ]
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> resetSelection [
	"Unselect every items"

	self
		deprecated: 'Please use #unselectAll instead'
		transformWith: '`@receiver resetSelection' 
						-> '`@receiver unselectAll'.

	self unselectAll
]

{ #category : #simulation }
SpAbstractListPresenter >> rightClickAtIndex: anIndex [
	
	self clickItem: anIndex.
	self halt.
	^ self menu: nil shifted: false
]

{ #category : #api }
SpAbstractListPresenter >> selectAll [

	self selection selectAll
]

{ #category : #api }
SpAbstractListPresenter >> selectIndex: anInteger [ 
	
	self selectionMode selectIndex: anInteger
]

{ #category : #api }
SpAbstractListPresenter >> selectIndexes: aCollection [
	self selectionMode selectIndexes: aCollection
]

{ #category : #api }
SpAbstractListPresenter >> selectItem: anItem [ 
	
	self selectionMode selectItem: anItem
]

{ #category : #api }
SpAbstractListPresenter >> selectItems: aCollection [
	self selectionMode selectItems: aCollection
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> selectedIndex [
	"Return the index of the selected item
	In the case of a multiple selection list, it returns the last selected item"
	
	self
		deprecated: 'Use the #selection object instead. This method assumes single selection'
		transformWith: '`@receiver selectedIndex'
						-> '`@receiver selection selectedIndex'.
	
	^  self selection selectedIndex
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> selectedIndex: anIndex [

	"Set the index of the item you want to be selected"
	self
		deprecated: 'Use #selectIndex: instead'
		transformWith: '`@receiver selectedIndex: `@arg'
						-> '`@receiver selectIndex: `@arg'.
	
	self selectIndex: anIndex
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> selectedIndexes [
	self
		deprecated: 'Use the #selection object instead. This method assumes multiple selection'
		transformWith: '`@receiver selectedIndexes'
						-> '`@receiver selection selectedIndexes'.

	^  self selection selectedIndexes
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> selectedItem [
	"Return the selected item.
	In the case of a multiple selection list, it returns the last selected item"
	
	self
		deprecated: 'Use the #selection object instead. This method assumes single selection'
		transformWith: '`@receiver selectedItem'
						-> '`@receiver selection selectedItem'.
	
	^ self selection selectedItem
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> selectedItem: anItem [
	"Set the item you want to be selected"

	self
		deprecated: 'Use #selectItem: instead'
		transformWith: '`@receiver selectedItem: `@arg'
						-> '`@receiver selectItem: `@arg'.

	self selectItem: anItem
]

{ #category : #api }
SpAbstractListPresenter >> selectedItems [
	"Return all the selected items in the case of a multiple selection list"

	^ self selectedItemsAtIndexes: self selection selectedIndexes
]

{ #category : #private }
SpAbstractListPresenter >> selectedItemsAtIndexes: aCollectionOfIndex [
	^ aCollectionOfIndex collect: [ :anIndex | self listElementAt: anIndex ]
]

{ #category : #api }
SpAbstractListPresenter >> selectedItemsSorted [
	"return all the selected items sorted by their index"

	^ self selectedItemsAtIndexes: self selection selectedIndexes sort
]

{ #category : #accessing }
SpAbstractListPresenter >> selection [
	
	^ selectionMode
]

{ #category : #accessing }
SpAbstractListPresenter >> selectionMode [
	
	^ selectionMode
]

{ #category : #api }
SpAbstractListPresenter >> selectionMode: aMode [
	
	selectionMode ifNotNil: [ 
		selectionMode transferSubscriptionsTo: aMode ].
	selectionMode := aMode
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> setIndex: anIndex [
	self
		deprecated: 'Use #selectIndex: instead'
		transformWith: '`@receiver setIndex: `@arg' -> '`@receiver selectIndex: `@arg'.
	self selectIndex: anIndex
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> setIndexes: aCollectionOfIndexes [
	"Set the indexexs of the selected items in case of multiple selection"
	self
		deprecated: 'Use the #selection object instead. This method assumes multiple selection'
		transformWith: '`@receiver setIndexes: `@arg'
						-> '`@receiver selection selectIndexes: `@arg'.

	self selection selectIndexes: aCollectionOfIndexes
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> setSelectedIndex: anIndex [
	self
		deprecated: 'Use #selectedIndex: instead'
		transformWith:
			'`@receiver setSelectedIndex: `@argument'
				-> '`@receiver selectedIndex: `@argument'.
	^ self selectIndex: anIndex
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> setSelectedItem: anIndex [
	self
		deprecated: 'Use #selectedItem: instead'
		transformWith:
			'`@receiver setSelectedItem: `@argument'
				-> '`@receiver selectedItem:`@argument'.
	^ self selectItem: anIndex
]

{ #category : #api }
SpAbstractListPresenter >> sortingBlock [
	^ self model sortingBlock
]

{ #category : #api }
SpAbstractListPresenter >> sortingBlock: aBlock [
	self model sortingBlock: aBlock
]

{ #category : #api }
SpAbstractListPresenter >> unselectAll [
	
	self selection unselectAll
]

{ #category : #api }
SpAbstractListPresenter >> unselectIndex: anInteger [ 
	
	self selection unselectIndex: anInteger
]

{ #category : #api }
SpAbstractListPresenter >> unselectItem: anInteger [ 
	
	self selection unselectItem: anInteger
]

{ #category : #accessing }
SpAbstractListPresenter >> verticalAlignment [
	^ verticalAlignment
]

{ #category : #'api-events' }
SpAbstractListPresenter >> whenActivatedDo: aBlock [ 
	
	activationBlock := aBlock
]

{ #category : #'api-events' }
SpAbstractListPresenter >> whenItemFilterBlockChangedDo: aBlock [

	self property: #itemFilter whenChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> whenListChanged: aBlock [
	"Specify a block to value after the contents of the list has changed"
	"Basically when you set a new list of items"
	self
		deprecated: 'Use #whenModelChangedDo: instead'
		transformWith: '`@receiver whenListChanged: `@argument'
						-> '`@receiver whenModelChangedDo: `@argument'.
	
	self whenModelChangedDo: aBlock
]

{ #category : #'api-events' }
SpAbstractListPresenter >> whenModelChangedDo: aBlock [

	model whenChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> whenMultiSelectionChanged: aBlock [
	"Set a block to value when the multiSelection value has changed"
	self deprecated: 'Should not use'
]

{ #category : #'api-events' }
SpAbstractListPresenter >> whenSearchChangedDo: aBlock [

	self property: #searchEnabled whenChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> whenSelectedIndexChangedDo: aBlock [
	"Set a block to value when the selection index has changed"
	
	self
		deprecated: 'Use #selection whenChangedDo: instead'
		transformWith: '`@receiver whenSelectedIndexChangedDo: `@argument'
						-> '`@receiver selection whenChangedDo: [ :selection | `@argument value: selection selectedIndex ]'.

	^ self  selection whenChangedDo: [ :selection | aBlock value: selection selectedIndex ]
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> whenSelectedItemChanged: aBlock [
	self
		deprecated: 'Use #whenSelectedItemChangedDo: instead'
		transformWith:
			'`@receiver whenSelectedItemChanged: `@argument'
				-> '`@receiver whenSelectedItemChangedDo: `@argument'.
	^ self
		whenSelectionChangedDo: [ :selection | aBlock cull: selection selectedItem ]
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> whenSelectedItemChangedDo: aBlock [
	"Set a block to value when the select item is changed"

	self
		deprecated: 'Use #whenSelectionChangedDo: instead'
		transformWith: '`@receiver whenSelectedItemChangedDo: `@argument'
						-> '`@receiver whenSelectionChangedDo: [ :selection | `@argument cull: selection selectedItem ]'.
	
	self selection whenChangedDo: [ :selection | aBlock cull: selection selectedItem ]
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> whenSelectedItemsChanged: aBlock [
	"Set a block to value when the select item is changed"
	
	self
		deprecated: 'Use #whenSelectionChangedDo: instead'
		transformWith: '`@receiver whenSelectedItemsChanged: `@argument'
						-> '`@receiver whenSelectionChangedDo: [ :selection | `@argument cull: selection selectedItems ]'.

	self selection whenChangedDo: [ :selection | aBlock cull: selection selectedItems ]
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> whenSelectionChanged: aBlock [
	
	self
		deprecated: 'Use #whenSelectionChangedDo: instead'
		transformWith: '`@receiver whenSelectionChanged: `@argument'
						-> '`@receiver whenSelectionChangedDo: `@argument'.
	^ self whenSelectionChangedDo: aBlock
]

{ #category : #'api-events' }
SpAbstractListPresenter >> whenSelectionChangedDo: aBlock [
	"Subscribe to changes in selection.
	This method works for all selection modes (single, multiple and no selection).
	The block used as argument will be sent an optional argument with the selection object."

	self selection whenChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> whenSelectionIndexChanged: aBlock [
	
	self
		deprecated: 'Use #selection whenChangedDo: instead'
		transformWith: '`@receiver whenSelectionIndexChanged: `@argument'
						-> '`@receiver selection whenChangedDo: [ :selection | `@argument value: selection selectedIndex ]'.
	^ self  selection whenChangedDo: [ :selection | aBlock value: selection selectedIndex ]
]

{ #category : #'Spec2-Deprecated' }
SpAbstractListPresenter >> whenSelectionIndexesChanged: aBlock [
	"Set a block to value when the selection index has changed"
	
	self
		deprecated: 'Use #whenSelectionChangedDo: instead'
		transformWith: '`@receiver whenSelectionIndexesChanged: `@argument'
						-> '`@receiver whenSelectionChangedDo: [ :selection | `@argument value: selection selectedIndexes ]'.
	
	self whenSelectionChangedDo: [ :selection | aBlock value: selection selectedIndexes ].
]

{ #category : #accessing }
SpAbstractListPresenter >> whenSelectionModeChangedDo: aBlock [
	selectionMode whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpAbstractListPresenter >> whenSortingBlockChangedDo: aBlock [
	self model whenSortingBlockChangedDo: aBlock
]
