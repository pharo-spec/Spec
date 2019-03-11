"
A TreeTablePresenter handles a tree table.
Tables defines columns (see #addColumn: and TableColumn hierarchy).
Tables receive items (see #items:) to feed the table.

self example

"
Class {
	#name : #TreeTablePresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'columns',
		'showColumnHeadersHolder',
		'isResizableHolder',
		'selection',
		'doubleClickActionHolder',
		'rootsHolder',
		'childrenBlock'
	],
	#category : #'Spec-Core-Widgets-Tree'
}

{ #category : #specs }
TreeTablePresenter class >> adapterName [

	^ #TreeTableAdapter
]

{ #category : #api }
TreeTablePresenter >> addColumn: aColumn [

	columns value: (columns value copyWith: aColumn)
]

{ #category : #'selection mode' }
TreeTablePresenter >> beMultipleSelection [
	
	| newSelectionMode |
	
	newSelectionMode := (TreeMultipleSelectionMode on: self)
								copyFrom: selection;
								yourself.
	
	selection := newSelectionMode.
]

{ #category : #api }
TreeTablePresenter >> beNotResizable [
	self isResizable: false
]

{ #category : #api }
TreeTablePresenter >> beResizable [
	self isResizable: true
]

{ #category : #private }
TreeTablePresenter >> children [

	^ childrenBlock
]

{ #category : #accessing }
TreeTablePresenter >> children: aBlock [

	childrenBlock := aBlock
]

{ #category : #accessing }
TreeTablePresenter >> childrenFor: anObject [ 

	^ self children value: anObject
]

{ #category : #accessing }
TreeTablePresenter >> columns [

	^ columns value
]

{ #category : #api }
TreeTablePresenter >> columns: aCollection [

	columns value: aCollection
]

{ #category : #private }
TreeTablePresenter >> doubleClickAction [

	^ doubleClickActionHolder value
]

{ #category : #'api-events' }
TreeTablePresenter >> doubleClickAction: aBlockClosure [ 
	
	doubleClickActionHolder value: aBlockClosure
]

{ #category : #simulation }
TreeTablePresenter >> doubleClickAtIndex: anInteger [ 
	
	self selectedIndex: anInteger.
	doubleClickActionHolder value cull: anInteger
]

{ #category : #api }
TreeTablePresenter >> hideColumnHeaders [

	showColumnHeadersHolder value: false
]

{ #category : #initialization }
TreeTablePresenter >> initialize [

	super initialize.
	showColumnHeadersHolder := true asValueHolder.
	columns := #() asValueHolder.
	isResizableHolder := false asValueHolder.
	selection := TreeSingleSelectionMode on: self.
	childrenBlock :=  [ :item | #() ].
	
	rootsHolder := #() asValueHolder.

]

{ #category : #accessing }
TreeTablePresenter >> isResizable [
	^ isResizableHolder value
]

{ #category : #accessing }
TreeTablePresenter >> isResizable: aBoolean [
	isResizableHolder value: aBoolean
]

{ #category : #testing }
TreeTablePresenter >> isShowingColumnHeaders [

	^ showColumnHeadersHolder value
]

{ #category : #private }
TreeTablePresenter >> itemAt: index of: anArray then: path [
	"dives into elements of tree to find the one that corresponds to path"
	| element |
	
	element := anArray at: index.
	^ path 
		ifNotEmpty: [ 
			self 
				itemAt: path first 
				of: (self childrenFor: element) 
				then: path allButFirst ]
		ifEmpty: [ 
			element ]
]

{ #category : #accessing }
TreeTablePresenter >> itemAtPath: anArray [

	^ self 
		itemAt: anArray first
		of: self roots
		then: anArray allButFirst
]

{ #category : #accessing }
TreeTablePresenter >> roots [

	^ rootsHolder value
]

{ #category : #accessing }
TreeTablePresenter >> roots: aCollection [

	rootsHolder value: aCollection.
	selection clearSelection
]

{ #category : #api }
TreeTablePresenter >> selectedItem [
	
	^ selection selectedItem
]

{ #category : #accessing }
TreeTablePresenter >> selection [
	
	^ selection
]

{ #category : #api }
TreeTablePresenter >> showColumnHeaders [

	showColumnHeadersHolder value: true
]

{ #category : #'api - events' }
TreeTablePresenter >> whenColumnsChangedDo: aBlockClosure [ 
	
	columns whenChangedDo: aBlockClosure 
]

{ #category : #'api-events' }
TreeTablePresenter >> whenIsResizableChangedDo: aBlock [
	isResizableHolder whenChangedDo: aBlock
]

{ #category : #'API - events' }
TreeTablePresenter >> whenRootsChangedDo: aBlockClosure [ 

	rootsHolder whenChangedDo: aBlockClosure
]

{ #category : #'api-events' }
TreeTablePresenter >> whenSelectedIndexChangedDo: aBlockClosure [ 
	
	self whenSelectionChangedDo: [ :selection | aBlockClosure cull: selection first ]
]

{ #category : #'api-events' }
TreeTablePresenter >> whenSelectedItemChangedDo: aBlockClosure [ 
	
	self whenSelectionChangedDo: [ :selection | aBlockClosure cull: selection second ]
]

{ #category : #'api-events' }
TreeTablePresenter >> whenSelectionChangedDo: aBlockClosure [ 
	
	selection whenChangedDo: [ aBlockClosure cull: selection ]
]

{ #category : #'api - events' }
TreeTablePresenter >> whenShowColumnHeadersChangedDo: aBlockClosure [ 
	
	showColumnHeadersHolder whenChangedDo: aBlockClosure 
]
