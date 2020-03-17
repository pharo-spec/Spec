Extension { #name : #SpMorphicTreeAdapter }

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> acceptDroppingMorph: draggedMorph event: event inMorph: source [
	| item |
	item := self widget ifNotNil: [ :w | w scrollerSubMorphFromPoint: event position ].
	item ifNil: [ ^ self ].
	^ self acceptDropBlock
		valueWithEnoughArguments: { draggedMorph model model. event. source model model model. item model nodeModel}
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> autoDeselection [

	^ self model autoDeselection
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> autoMultiSelection [

	^ self model autoMultiSelection
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> buildWidget [
	^ MorphTreeMorph new
		model: self treeModel;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		spInitializeColumsFrom: self;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		autoDeselection: self autoDeselection;
		resizerWidth: self resizerWidth;
		columnInset: self columnInset;
		iconBlock: self iconBlock;
		rowInset: self rowInset;
		keystrokeActionSelector: #keyStroke:;
		multiSelection: self multiSelection;
		autoMultiSelection: self autoMultiSelection;
		removeOnlyLastSelected: self selectOnlyLastHighlighted;
		isCheckList: self isCheckList;
		doubleClickSelector: #doubleClick;
		getMenuSelector: #menu:shifted:;
		rowColorForEven: self evenRowColor;
		rowColorForOdd: self oddRowColor;
		buildContents;
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> changed: aSymbol [

	treeModel changed: aSymbol
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> childrenFor: aNode [

	^ self model childrenFor: aNode
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> collapseAll [

	self treeModel collapseAll
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> columnInset [

	^ self model columnInset
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> columns [

	^ self model columns collect: [ :each | each buildWithSpec ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> columns: newColumns [

	self widgetDo: [ :w || columns |
		columns := newColumns collect: [ :each | each buildWithSpec ]. 
		w columns: columns.
		w resizerChanged.
		w updateList ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> doesNotUnderstand: aMessage [

	(self treeModel respondsTo: aMessage selector) 
		ifFalse: [ ^ super doesNotUnderstand: aMessage ].
		
	^ self treeModel 
		perform: aMessage selector 
		withArguments: aMessage arguments
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> doubleClick [

	^ self model doubleClick
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> evenRowColor [

	^ self model evenRowColor
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> evenRowColor: aColor [

	^ self widget rowColorForEven: aColor
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> expandAll [

	self treeModel expandAll
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> expandRoots [

	self treeModel expandRoots
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> filterWith: aFilter [
	
	self widgetDo: [ :w || nodes |
		nodes := w model rootNodes.
		nodes do: [:r | r nodeModel updateAccordingTo: aFilter].
	
		self removeRootsSuchAs: [:n | (aFilter keepTreeNode: n) not and: [n isEmpty]].

		self changed: #rootNodes ].
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> iconBlock [

	^ [:each | self iconFor: each ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> iconFor: aNode [

	^ self model iconFor: aNode
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> initialize [

	super initialize.

	treeModel := SpTreeModel model: self.	
	treeModel announcer
		when: MorphTreeSelectionChanged
		send: #onMorphTreeSelectionChanged:
		to: self.
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> isCheckList [

	^ self model isCheckList
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> isCheckList: aBoolean [

	self widgetDo: [ :w | w isCheckList: aBoolean ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter class >> isDeprecated [ 

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> keyStroke: aKeyStroke [

	^ self model keyStroke: aKeyStroke
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> menu: aMenu shifted: aBoolean [

	^ (self model menu: aMenu shifted: aBoolean) 
		ifNotNil: [ :menuModel | menuModel buildWithSpecAsPopup ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> multiSelection [

	^ self model multiSelection
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> oddRowColor [

	^ self model oddRowColor
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> oddRowColor: aColor [

	^ self widget rowColorForOdd: aColor
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> onMorphTreeSelectionChanged: ann [
	| items |
	
	items := (ann selection
		ifNil: [ #() ]
		ifNotNil: [:selection | selection selectedNodes ]).
		
	items := items collect: [ :each | each nodeModel ].

	self model selectedItems: items
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> preferedPaneColor [

	^ self model preferedPaneColor
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> removeRootsSuchAs: aBlock [

	self widgetDo: [ :w | w model rootNodes removeAllSuchThat: [ :node | aBlock value: node nodeModel ] ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> resizerWidth [

	^ self model resizerWidth
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> rootNodeFromItem: item [
	| node |
	
	node := (item isKindOf: SpTreeNodePresenter)
		ifTrue: [ item ]
		ifFalse: [ self rootNodeHolder cull: item ].
		
	node container: self model.
	^ node buildWithSpec
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> rootNodeHolder [

	^ self model rootNodeHolder
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> roots [

	^ self model roots
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> rowInset [

	^ self model rowInset
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> selectAdd [

	self widgetDo: [ :w | w selectAll ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> selectOnlyLastHighlighted [

	^ self model selectOnlyLastHighlighted
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> setRoots: aCollection [

	treeModel rootItems: aCollection
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> treeModel [
	^ treeModel
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> updateTree [

	self treeModel resetRootNodes.
	self treeModel changed: #rootNodes.
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapter >> wrapItem: anItem [

	^ self model wrapItem: anItem
]
