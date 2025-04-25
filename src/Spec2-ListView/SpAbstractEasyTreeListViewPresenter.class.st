"
A base for tree presenters, it defines basic functionality common to all trees.
"
Class {
	#name : 'SpAbstractEasyTreeListViewPresenter',
	#superclass : 'SpAbstractEasyPresenter',
	#classTraits : 'SpTSearchable classTrait',
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'testing' }
SpAbstractEasyTreeListViewPresenter class >> isAbstract [

	^ super isAbstract or: [ self = SpAbstractTreePresenter ]
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> children: aBlock [
	"Set a block to answer the children of a node when it is expanded.
	 `aBlock` receives one argument, the node element to expand.
	 If there are no children to answer, `aBlock` needs to answer an empty collection."		

	contentView children: aBlock
]

{ #category : 'simulation' }
SpAbstractEasyTreeListViewPresenter >> clickAtPath: aPath [

	contentView clickAtPath: aPath
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> collapseAll [
	"Collapse all nodes of the tree. "

	contentView collapseAll
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> collapsePath: aPath [
	"Collapse the tree path.
	`aPath` is the path to collapse. A path is an array of node indexes (e.g. #(1 2 3))"

	contentView collapsePath: aPath
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> contextMenu [

	^ contentView contextMenu
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> contextMenu: aBlock [

	contentView contextMenu: aBlock
]

{ #category : 'transmission' }
SpAbstractEasyTreeListViewPresenter >> defaultInputPort [

	^ self inputRootsPort
]

{ #category : 'simulation' }
SpAbstractEasyTreeListViewPresenter >> doubleClickAtPath: aPath [

	contentView doubleClickAtPath: aPath
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> expandAll [
	"Expand all nodes of the tree. 
	 WARNING: If your tree is big, this operation can be slow."

	contentView expandAll
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> expandPath: aPath [
	"Expand the tree path.
	`aPath` is the path to expand. A path is an array of node indexes (e.g. #(1 2 3))"

	contentView expandPath: aPath
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> expandRoots [
	"Expand all roots of the tree"

	contentView expandRoots
]

{ #category : 'transmission' }
SpAbstractEasyTreeListViewPresenter >> inputRootsPort [

	^ SpRootsPort newPresenter: self
]

{ #category : 'testing' }
SpAbstractEasyTreeListViewPresenter >> isExpanded: aPath [

	^ contentView isExpanded: aPath

]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> items: aCollection [
	"Set the roots of a tree. This is a convenience method, synonym of `SpTreePresenter>>#roots:`"

	self roots: aCollection
]

{ #category : 'private' }
SpAbstractEasyTreeListViewPresenter >> lazilyComputeChildren: aBoolean [ 
	
	self flag: #TOREMOVE.
]

{ #category : 'transmission' }
SpAbstractEasyTreeListViewPresenter >> outputActivationPort [
	
	^ SpActivationPort newPresenter: self
]

{ #category : 'transmission' }
SpAbstractEasyTreeListViewPresenter >> outputSelectionPort [
	
	^ SpSelectionPort newPresenter: self
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> refresh [
	"Forces a refresh of the tree. 
	 This is useful when some model contents has changed, but we do not want to reset the whole list 
	 (and losing selections with it)"

	contentView refresh
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> roots [
	"Answer the roots of the tree"

	^ contentView roots
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> roots: aCollection [
	"Set the roots of the tree table.
	 This is the starting point from where the whole tree will be shown."

	contentView roots: aCollection
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectItem: anItem [
	"Select `anItem` if it is included in model list.
	 It does not scrolls to selected element."

	contentView selectItem: anItem
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectItems: aListOfItem [
	"Select items included in `aCollection` if they are included in model list.
	 NOTE: In single selection mode it will select the first element of `aCollection` 
	 It does not scrolls to selected element."

	contentView selectItems: aListOfItem
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectPath: aPath [
	"Selects element in `aPath`
	`aPath` is the path to select. A path is an array of node indexes (e.g. #(1 2 3)).
	 It does not scrolls to selected element."

	contentView selectPath: aPath
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectPath: aPath scrollToSelection: shouldScrollToSelection [
	"Selects element in `aPath`
	`aPath` is the path to select. A path is an array of node indexes (e.g. #(1 2 3)).
	 If `shouldScrollToSelection` is true, it will scroll to selected element.
	 IMPORTANT: Scrolling to selection just has sense when the widget is already shown, because before it 
	 is displayed it does not has real bounds. In morphic (and gtk) it has a minimal extent assigned, 
	 but that will change as soon as the widget is inserted in a container and the container applies its 
	 layout."

	contentView 
		selectPath: aPath 
		scrollToSelection: shouldScrollToSelection
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectPathByItems: pathArray [

	contentView selectPathByItems: pathArray 
		
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectPathByItems: pathArray scrollToSelection: aBoolean [
	"IMPORTANT: Scrolling to selection just has sense when the widget is already shown, because before it 
	 is displayed it does not has real bounds. In morphic (and gtk) it has a minimal extent assigned, 
	 but that will change as soon as the widget is inserted in a container and the container applies its 
	 layout."
		
	contentView 
		selectPathByItems: pathArray 
		scrollToSelection: aBoolean
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectPaths: pathArray [
	"Selects all elements in `pathsArray``
	`pathsArray` is an array of paths. A path is an array of node indexes (e.g. #(1 2 3))"

	contentView selectPaths: pathArray
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectedItem [
	"Return selected item."
	
	^ contentView selectedItem
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectedItems [
	"Return all the selected items in the case of a multiple selection list"
	
	^ contentView selectedItems
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selection [
	"Answer the selection object (an instance of `SpSingleSelectionMode` or `SpMultipleSelectionMode`).
	 This is not the item selected, but the selection container (it may contain one or many selected 
	 items)"
	
	^ contentView selection
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> selectionMode [
	"Answer the selection object (an instance of `SpSingleSelectionMode` or `SpMultipleSelectionMode`).
	 This is not the item selected, but the selection container (it may contain one or many selected 
	 items).
	 This is the same as `SpAbstractListPresenter>>#selection`"

	^ contentView selectionMode
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> unselectAll [ 
	"Remove all selections"

	self selection unselectAll
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> unselectItem: anItem [
	"Remove selection of element `anItem`"

	self selection unselectItem: anItem
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> unselectPath: aPath [
	"Unselects element in `aPath`
	`aPath` is the path to select. A path is an array of node indexes (e.g. #(1 2 3))"

	self selection unselectPath: aPath
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> updateRootsKeepingSelection: aCollection [ 
	"Update tree roots keeping current selection. 
	 WARNING: aCollection must includes the elements selected."

	contentView updateRootsKeepingSelection: aCollection
]

{ #category : 'accessing' }
SpAbstractEasyTreeListViewPresenter >> verticalAlignment [ 

	^ contentView verticalAlignment
]

{ #category : 'api - events' }
SpAbstractEasyTreeListViewPresenter >> whenMenuChangedDo: aBlock [

	contentView whenMenuChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractEasyTreeListViewPresenter >> whenMultiSelectionChangedDo: aBlock [
	"Inform when selection mode has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"
	
	contentView whenMultiSelectionChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractEasyTreeListViewPresenter >> whenRootsChangedDo: aBlock [
	"Inform when roots have changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	contentView whenRootsChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractEasyTreeListViewPresenter >> whenSelectedIndexChangedDo: aBlock [ 
	"Inform when selected index has changed. 
	 `aBlock` receives one optional argument (the new element)."
	
	contentView whenSelectedIndexChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractEasyTreeListViewPresenter >> whenSelectedItemChangedDo: aBlock [
	"Inform when selected index has changed. 
	 `aBlock` receives one optional argument (the new element)."
	
	contentView whenSelectedItemChangedDo: aBlock

]

{ #category : 'api - events' }
SpAbstractEasyTreeListViewPresenter >> whenShowColumnHeadersChangedDo: aBlock [ 
	"Inform when showColumnHeaders property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"
	
	contentView whenShowColumnHeadersChangedDo: aBlock
]
