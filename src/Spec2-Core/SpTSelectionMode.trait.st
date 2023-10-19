"
Add selectable api to widgets
"
Trait {
	#name : 'SpTSelectionMode',
	#instVars : [
		'selectionMode'
	],
	#category : 'Spec2-Core-Widgets-Table',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Table'
}

{ #category : 'api - selection' }
SpTSelectionMode >> selectAll [
	"Select all items in the list or table. 
	 It does not triggers activation event."
	
	self selection selectAll
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectFirst [
	"Select first element in list. 
	 Useful to avoid selecting by index."
	
	^ self selectIndex: 1
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectIndex: anInteger [ 
	"Select item at position `anInteger`.
	 Selection will not scroll the presenter view to show selected element."
	
	self selectionMode selectIndex: anInteger
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectIndex: anIndex scrollToSelection: shouldScrollToSelection [
	"Select item at position `anInteger`.
	 If `shouldScrollToSelection` is true, selection will scroll the presenter view 
	 to show selected element."

    self selectIndex: anIndex.
    shouldScrollToSelection ifTrue: [ 
        self verticalAlignment desiredVisibleRow: anIndex ].
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectIndexes: aCollectionOfIndexes [
	"Select items at positions included in `aCollectionOfIndexes`.
	 NOTE: in single selection mode, first element of `aCollectionOfIndexes` will be selected.
	 Selection will not scroll the presenter view to show selected(s) element(s)."

	self selectionMode selectIndexes: aCollectionOfIndexes
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectIndexes: aCollectionOfIndexes scrollToSelection: shouldScrollToSelection [
	"Select items at positions included in `aCollectionOfIndexes`.
	 NOTE: in single selection mode, first element of `aCollectionOfIndexes` will be selected.
	 If `shouldScrollToSelection` is true, selection will scroll the presenter view 
	 to show first selected element."
  
  self selectIndexes: aCollectionOfIndexes.
    shouldScrollToSelection ifTrue: [ 
        self verticalAlignment desiredVisibleRow: aCollectionOfIndexes first ].
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectItem: anItem [ 
	"Select `anItem` if it is included in model list.
	 It does not scrolls to selected element."
	
	self selectionMode selectItem: anItem
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectItem: anItem scrollToSelection: shouldScrollToSelection [
	"Select item `anItem`.
	 If `shouldScrollToSelection` is true, selection will scroll the presenter view 
	 to show selected element."

	self 
		selectIndex: (self items indexOf: anItem) 
		scrollToSelection: shouldScrollToSelection
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectItems: aCollection [
	"Select items included in `aCollection` if they are included in model list.
	 NOTE: In single selection mode it will select the first element of `aCollection` 
	 It does not scrolls to selected element."

	self selectionMode selectItems: aCollection
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectedItem [
	"Return selected item."

	^ self selection selectedItem
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectedItems [
	"Return all the selected items in the case of a multiple selection list"

	^ self selection selectedItems
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectedItemsSorted [
	"Return all the selected items sorted by their index"

	^ self itemsAt: self selection selectedIndexes sort
]

{ #category : 'api - selection' }
SpTSelectionMode >> selection [
	"Answer the selection object (an instance of `SpSingleSelectionMode` or `SpMultipleSelectionMode`).
	 This is not the item selected, but the selection container (it may contain one or many selected 
	 items)"
	
	^ self selectionMode
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectionMode [
	"Answer the selection object (an instance of `SpSingleSelectionMode` or `SpMultipleSelectionMode`).
	 This is not the item selected, but the selection container (it may contain one or many selected 
	 items).
	 This is the same as `SpAbstractListPresenter>>#selection`"
	
	^ selectionMode
]

{ #category : 'api - selection' }
SpTSelectionMode >> selectionMode: aMode [
	
	selectionMode ifNotNil: [ 
		selectionMode transferSubscriptionsTo: aMode ].
	selectionMode := aMode
]

{ #category : 'api - selection' }
SpTSelectionMode >> unselectAll [
	"Remove all selections"
	
	self selection unselectAll
]

{ #category : 'api - selection' }
SpTSelectionMode >> unselectIndex: anInteger [ 
	"Remove selection of element at index `anInteger`"
	
	self selection unselectIndex: anInteger
]

{ #category : 'api - selection' }
SpTSelectionMode >> unselectItem: anObject [ 
	"Remove selection of element `anObject`"
	
	self selection unselectItem: anObject
]

{ #category : 'api - events' }
SpTSelectionMode >> whenNoneSelectedDo: aBlock [
	"Inform when the list has clean selection (there are no items selected).
	 `aBlock` receives zero arguments"

	self whenSelectionChangedDo: [ :selection | 
		selection selectedItem 
			ifNil: [ aBlock value ] ]
]

{ #category : 'api - events' }
SpTSelectionMode >> whenSelectedDo: aBlock [
	"Inform when an item was selected (a real object in the items list).
	 `aBlock` receives one argument (the new selected element)"

	self whenSelectionChangedDo: [ :selection | 
		selection selectedItem 
			ifNotNil: [ :item | aBlock value: item ] ]
]

{ #category : 'api - events' }
SpTSelectionMode >> whenSelectedItemChangedDo: aBlock [
	"Inform when the selected item is changed.
	 `aBlock` receive one optional argument: the selected item (can be nil)"

	self selection whenChangedDo: [ aBlock cull: self selectedItem ]
]

{ #category : 'api - events' }
SpTSelectionMode >> whenSelectionChangedDo: aBlock [
	"Inform when there are changes in selection.
	This method works for all selection modes (single, multiple and no selection).
	`aBlock` receives an optional argument with the selection object."

	self selection whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpTSelectionMode >> whenSelectionModeChangedDo: aBlock [
	"Inform when selection mode (single/multiple) changed. 
	 `aBlock` receives zero arguments."

	selectionMode whenChangedDo: aBlock
]
