"
I am the Spec presenter of a MorphTreeMorph tree.
"
Class {
	#name : #SpTreePresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'childrenBlockHolder',
		'menuBlockHolder',
		'rootsHolder',
		'selectionHolder',
		'autoMultiSelection',
		'columnInset',
		'doubleClick',
		'evenRowColor',
		'isCheckList',
		'keyStroke',
		'multiSelection',
		'oddRowColor',
		'preferedPaneColor',
		'resizerWidth',
		'rowInset',
		'displayBlock',
		'columns',
		'treeUpdated',
		'iconBlock',
		'autoDeselection',
		'allowMenuOnNoItem',
		'rootNodeHolder',
		'removeOnlyLastSelected',
		'highlightedItem',
		'hasChildrenBlockHolder',
		'autoRefreshOnExpand'
	],
	#category : #'Spec2-Deprecated-Replaced'
}

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter class >> adapterName [
	^ #TreeAdapter
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter class >> example [
	<sampleInstance>
	| m |

	m := self new.
	m openWithSpec.
	
	m roots: #(a b c d).
	m childrenBlock: [:it | it = #c 
		ifTrue: [ {1. 2. 3} ]
		ifFalse: [ {} ]].
	m displayBlock: [:item | item isSymbol
		ifTrue: [ item asUppercase , ' symbol' ]
		ifFalse: [ item printString ]].
	m 
		dragEnabled: true;
		dropEnabled: true;
		wantDropBlock: [ :draggedItem :event :source | 
			draggedItem isTransferable and: [ draggedItem source = m ] ];
		acceptDropBlock: [ :transfer :event :source :receiver | 
			Transcript 
				show: 'Dragged node '; 
				show: transfer passenger content; 
				show: ' to node '; 
				show: receiver content; 
				cr ].
		
	^ m
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter class >> exampleOfAutoRefreshOnExpand [
	"Each time a node is expanded, the computation of the children is made again, instead of being cached as it is usually"

	SpTreePresenter new
		childrenBlock: [ :number | 
			self logCr: 'Compute children of ', number asString.
			1 to: number ];
		hasChildrenBlock: [ :number | true ];
		roots: (1 to: 10);
		autoRefreshOnExpand: true;
		openWithSpec
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter class >> exampleWithCustomColumnsAndNodes [
	<haltOrBreakpointForTesting>
	| m col1 col2 |

	m := SpTreePresenter new.
	m roots: #(#a #b #c #d).
	m rootNodeHolder: [ :item | 
		SpTreeNodePresenter new
			content: item;
			icon: (self iconNamed: #smallConfigurationIcon)
	].
	
	m openWithSpec.
	
	col1 := SpTreeColumnPresenter new
		displayBlock: [ :node | node content asString ];
		headerLabel: 'Character'.
	col2 := SpTreeColumnPresenter new
		displayBlock: [ :node | (Character value: node content asString first asciiValue + 1) asString ];
		headerLabel: 'Character +1';
		headerIcon: (self iconNamed: #smallBackIcon).
	
	m
		columns: {col1. col2};
		dragEnabled: true;
		dropEnabled: true;
		acceptDropBlock: [ :transfer :event :source :receiver | self halt ].
		
	col2 
		headerLabel: 'Character +2';
		headerIcon: (self iconNamed: #smallBackIcon);
		displayBlock: [ :node | (Character value: node content asString first asciiValue + 2) asString ].
	
	m rootNodeHolder: [ :item | 
		SpTreeNodePresenter new
			content: (Character value: (item asString first asciiValue + 5)) asSymbol;
			icon: (self iconNamed: #smallFullscreenIcon)
	].

	col1 headerIcon: (self iconNamed: #nautilusIcon).
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter class >> exampleWithCustomColumnsAndNodesAndChildren [
	<haltOrBreakpointForTesting>

	| m col1 col2 |
	m := SpTreePresenter new.
	m roots: #(#a #b #c #d).
	m
		rootNodeHolder: [ :item | 
			SpTreeNodePresenter new
				content: item;
				children: [ (1 to: item asString first asciiValue) collect: [ :e | SpTreeNodePresenter new content: e ] ];
				icon: (m iconNamed: #smallConfigurationIcon) ].
	m openWithSpec.
	col1 := SpTreeColumnPresenter new
		displayBlock: [ :node | node content asString ];
		headerAction: [ self halt ].
	col2 := SpTreeColumnPresenter new
		displayBlock: [ :node | (Character value: node content asString first asciiValue + 1) asString ].
	m
		columns:
			{col1.
			col2};
		dragEnabled: true;
		dropEnabled: true;
		acceptDropBlock: [ :transfer :event :source :receiver | self halt ].
	col2
		displayBlock: [ :node | (Character value: node content asString first asciiValue + 2) asString ]
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter class >> exampleWithNoSpecifiedNodes [
	"self exampleWithNoSpecifiedNodes"

	SpTreePresenter new
		 roots: (1 to: 5);
		 childrenBlock: [ :item | 1+item to: 5+item ];
		 openWithSpec
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter class >> isDeprecated [ 

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> allowMenuOnNoItem [

	^ allowMenuOnNoItem value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> allowMenuOnNoItem: aBoolean [

	allowMenuOnNoItem value: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> autoDeselection [

	^ autoDeselection value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> autoDeselection: aBoolean [

	autoDeselection value: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> autoMultiSelection [

	^ autoMultiSelection value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> autoMultiSelection: aBoolean [

	autoMultiSelection value: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> autoRefreshOnExpand [
	^ autoRefreshOnExpand value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> autoRefreshOnExpand: aBoolean [
	autoRefreshOnExpand value: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> beCheckList [

	self isCheckList: true
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> childrenBlock [
	"Return the block used to retrieve the children of a node.
	The optional block arguments are:
		- the node
		- the tree"

	^ childrenBlockHolder value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> childrenBlock: aBlock [
	"Set the block used to retrieve the children of a node.
	The optional block arguments are:
		- the node
		- the tree"

	childrenBlockHolder value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> childrenFor: anItem [

	^ self childrenBlock cull: anItem cull: self
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> collapseAll [
	
	self changed: #collapseAll with: #()
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> columnInset [

	^ columnInset value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> columnInset: anInteger [

	columnInset value: anInteger
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> columns [
	
	^ columns value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> columns: aCollection [
	
	columns value: aCollection
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> defaultNodeFor: item [

	^ SpTreeNodePresenter new
		content: item;
		children: [ self childrenFor: item ];
		hasChildren: [ self hasChildrenFor: item ];
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> deselectAll [
	
	self changed: #deselectAll with: #()
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> displayBlock [
	"Return the block used to generate the display of the items.
	The optioanl block arguments are:
		- the item
		- the tree"

	^ displayBlock value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> displayBlock: aBlock [
	"Set the block used to generate the display of the items.
	The optioanl block arguments are:
		- the item
		- the tree"

	displayBlock value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> doubleClick [

	doubleClick value value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> doubleClick: aBlock [

	doubleClick value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> evenRowColor [

	^ evenRowColor value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> evenRowColor: aColor [

	evenRowColor value: aColor
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> eventKeyStrokesForNextFocus [
	"String describing the keystroke to perform to jump to the next widget"	
		
	^ { Character tab asKeyCombination }
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> eventKeyStrokesForPreviousFocus [
	"String describing the keystroke to perform to jump to the previous widget"
	
	^ { Character tab shift asKeyCombination }
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> expandAll [

	self changed: #expandAll with: #()
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> expandRoots [

	self changed: #expandRoots with: #()
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> filterWith: aFilter [
	
	self selection: nil.
	self updateTree.

	self expandAll.
	self changed: #filterWith: with: {aFilter}.
	
	self expandAll.
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> hasChildrenBlock [
	"Get the block used to check if a node has children.
	The optional block arguments are:
		- the node
		- the tree"

	^ hasChildrenBlockHolder value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> hasChildrenBlock: aBlock [
	"Set the block used to  check if a node has children.
	The optional block arguments are:
		- the node
		- the tree"

	hasChildrenBlockHolder value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> hasChildrenFor: anItem [

	^ self hasChildrenBlock cull: anItem cull: self
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> hasSelectedItem [
	"Return true if the tree contains any selected items"
	
	^ selectionHolder value isNotEmpty
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> highlightedItem [
	"Return the currently highlighted item"

	^ highlightedItem value
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> highlightedItem: anItem [
	"Set the highlightedItem item"
	"In the case of keyboard navigation with checklist, it may differ from the last selected item"
	
	highlightedItem value: anItem
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> iconBlock: aBlock [

	iconBlock value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> iconFor: aNode [

	^ iconBlock value cull: aNode content cull: aNode
]

{ #category : #'*Spec2-Deprecated' }
SpTreePresenter >> initialize [
	super initialize.

	childrenBlockHolder := [ {} ] asValueHolder.
	hasChildrenBlockHolder := [ :item | (self childrenFor: item) notEmpty ] asValueHolder.
	rootsHolder := {} asValueHolder.
	selectionHolder := {} asValueHolder.
	menuBlockHolder := [] asValueHolder.
	displayBlock := [:item | item asString ] asValueHolder.
	
	removeOnlyLastSelected := false asValueHolder.
	autoDeselection := true asValueHolder.
	autoMultiSelection := false asValueHolder.
	columnInset := 5 asValueHolder.
	doubleClick := [] asValueHolder.
	allowMenuOnNoItem := false asValueHolder.
	isCheckList := false asValueHolder.
	keyStroke := [ :key | ] asValueHolder.
	multiSelection := false asValueHolder.
	evenRowColor := self theme backgroundColor asValueHolder.
	oddRowColor := self theme backgroundColor asValueHolder.
	preferedPaneColor := self theme backgroundColor asValueHolder.
	resizerWidth := 2 asValueHolder.
	rowInset := 2 asValueHolder.
	iconBlock := [ :each : node | node icon ] asValueHolder.
	highlightedItem := nil asValueHolder.
	rootNodeHolder := [ :item |
		SpTreeNodePresenter new 
			content: item;
			children: [ self childrenFor: item ] ] asValueHolder.
	
	columns := { SpTreeColumnPresenter new
		displayBlock: [:node | (self wrapItem: node content) ] } asValueHolder.
	
	autoRefreshOnExpand := false asValueHolder.
	
	"Since my nodes are already morphs, dragging them will actually extract them from their owner"
	self dragTransformationBlock: [ :item :source | item complexContents ].

	treeUpdated := nil asValueHolder.

	self registerEvents
]
