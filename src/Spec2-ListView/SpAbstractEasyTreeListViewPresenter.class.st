"
A base for tree presenters, it defines basic functionality common to all trees.
"
Class {
	#name : 'SpAbstractEasyTreeListViewPresenter',
	#superclass : 'SpAbstractEasyPresenter',
	#classTraits : 'SpTSearchable classTrait',
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
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

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> collapseAll [
	"Collapse all nodes of the tree. "

	self withAdapterPerformOrDefer: [ :anAdapter | 
		anAdapter collapseAll ]
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> collapsePath: aPath [
	"Collapse the tree path.
	`aPath` is the path to collapse. A path is an array of node indexes (e.g. #(1 2 3))"

	self withAdapterPerformOrDefer: [ :anAdapter |
		anAdapter collapsePath: aPath ]
]

{ #category : 'transmission' }
SpAbstractEasyTreeListViewPresenter >> defaultInputPort [

	^ self inputRootsPort
]

{ #category : 'transmission' }
SpAbstractEasyTreeListViewPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> expandAll [
	"Expand all nodes of the tree. 
	 WARNING: If your tree is big, this operation can be slow."

	self withAdapterPerformOrDefer: [ :anAdapter | 
		anAdapter expandAll ]
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> expandPath: aPath [
	"Expand the tree path.
	`aPath` is the path to expand. A path is an array of node indexes (e.g. #(1 2 3))"

	self withAdapterPerformOrDefer: [ :anAdapter |
		anAdapter expandPath: aPath ]
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> expandRoots [
	"Expand all roots of the tree"

	self withAdapterPerformOrDefer: [ :anAdapter | 
		anAdapter expandRoots ]
]

{ #category : 'initialization' }
SpAbstractEasyTreeListViewPresenter >> initialize [
	
	super initialize.
	self initializeTSearchable.
	self registerEvents
]

{ #category : 'transmission' }
SpAbstractEasyTreeListViewPresenter >> inputRootsPort [

	^ SpRootsPort newPresenter: self
]

{ #category : 'api' }
SpAbstractEasyTreeListViewPresenter >> items: aCollection [
	"Set the roots of a tree. This is a convenience method, synonym of `SpTreePresenter>>#roots:`"

	self roots: aCollection
]

{ #category : 'private' }
SpAbstractEasyTreeListViewPresenter >> lazilyComputeChildren: aBoolean [ 
	
	self flag: #TODO.
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

	self withAdapterDo: [ :anAdapter | anAdapter refreshTree ]
]

{ #category : 'initialization' }
SpAbstractEasyTreeListViewPresenter >> registerEvents [

	"self whenMenuChangedDo: [ 
		self withAdapterDo: [ :anAdapter | anAdapter updateMenu ] ]"
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

	self selection selectItem: anItem
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectItems: aListOfItem [
	"Select items included in `aCollection` if they are included in model list.
	 NOTE: In single selection mode it will select the first element of `aCollection` 
	 It does not scrolls to selected element."

	self selection selectItems: aListOfItem
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectPath: aPath [
	"Selects element in `aPath`
	`aPath` is the path to select. A path is an array of node indexes (e.g. #(1 2 3)).
	 It does not scrolls to selected element."

	self selection selectPath: aPath
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

	self selectPathByItems: pathArray scrollToSelection: false
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectPathByItems: pathArray scrollToSelection: aBoolean [
	"IMPORTANT: Scrolling to selection just has sense when the widget is already shown, because before it 
	 is displayed it does not has real bounds. In morphic (and gtk) it has a minimal extent assigned, 
	 but that will change as soon as the widget is inserted in a container and the container applies its 
	 layout."
	| pathIndexes |

	pathIndexes := self pathIndexOf: pathArray.
	pathIndexes size > 1 ifTrue: [ 
		self expandPath: pathIndexes allButLast ].
	self 
		selectPath: pathIndexes
		scrollToSelection: aBoolean
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectPaths: pathArray [
	"Selects all elements in `pathsArray``
	`pathsArray` is an array of paths. A path is an array of node indexes (e.g. #(1 2 3))"

	self selection selectPaths: pathArray
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectedItem [
	"Return selected item."
	
	^ self selection selectedItem
]

{ #category : 'api - selection' }
SpAbstractEasyTreeListViewPresenter >> selectedItems [
	"Return all the selected items in the case of a multiple selection list"
	
	^ self selection selectedItems
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
SpAbstractEasyTreeListViewPresenter >> whenSelectionChangedDo: aBlock [ 
	"Inform when selection has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"
	
	contentView whenSelectionChangedDo: aBlock
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
