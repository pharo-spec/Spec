"
I'm a base presenter for tables (simple tables and trees).
I define common members for my children.

"
Class {
	#name : #TableBasePresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'columns',
		'showColumnHeadersHolder',
		'isResizableHolder',
		'selectionHolder',
		'doubleClickActionHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #api }
TableBasePresenter >> addColumn: aColumn [

	columns := columns copyWith: aColumn
]

{ #category : #api }
TableBasePresenter >> beNotResizable [
	self isResizable: false
]

{ #category : #api }
TableBasePresenter >> beResizable [
	self isResizable: true
]

{ #category : #accessing }
TableBasePresenter >> columns [

	^ columns
]

{ #category : #api }
TableBasePresenter >> columns: aCollection [

	columns := aCollection
]

{ #category : #'api-events' }
TableBasePresenter >> doubleClickAction: aBlockClosure [ 
	
	doubleClickActionHolder value: aBlockClosure
]

{ #category : #simulation }
TableBasePresenter >> doubleClickAtIndex: anInteger [ 
	
	self selectedIndex: anInteger.
	doubleClickActionHolder value cull: anInteger
]

{ #category : #api }
TableBasePresenter >> hideColumnHeaders [

	showColumnHeadersHolder value: false
]

{ #category : #initialization }
TableBasePresenter >> initialize [ 

	super initialize.
	showColumnHeadersHolder := true asValueHolder.
	columns := #().
	isResizableHolder := false asValueHolder.
	selectionHolder := SelectionValueHolder new.
	
	showColumnHeadersHolder whenChangedDo: [ self showColumnHeadersChanged ]
]

{ #category : #accessing }
TableBasePresenter >> isResizable [
	^ isResizableHolder value
]

{ #category : #accessing }
TableBasePresenter >> isResizable: aBoolean [
	isResizableHolder value: aBoolean
]

{ #category : #testing }
TableBasePresenter >> isShowingColumnHeaders [

	^ showColumnHeadersHolder value
]

{ #category : #api }
TableBasePresenter >> selectedIndex [
	
	^ selectionHolder index value
]

{ #category : #api }
TableBasePresenter >> selectedIndex: anIndex [
	
	| selectedIndex selection |
	selectedIndex := anIndex.
	selection := self items
		at: selectedIndex
		ifAbsent: [ 
			selectedIndex := 0.
			nil ].

	selectionHolder index value: selectedIndex.
	selectionHolder selection value: selection.
]

{ #category : #api }
TableBasePresenter >> selectedItem [
	
	^ selectionHolder selection value
]

{ #category : #api }
TableBasePresenter >> selectedItem: anInteger [ 
	
	| index |
	index := self items indexOf: anInteger.
	self selectedIndex: index
]

{ #category : #api }
TableBasePresenter >> showColumnHeaders [

	showColumnHeadersHolder value: true
]

{ #category : #private }
TableBasePresenter >> showColumnHeadersChanged [

	self changed: #showColumnHeaders
]

{ #category : #'api-events' }
TableBasePresenter >> whenIsResizableChangedDo: aBlock [
	isResizableHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
TableBasePresenter >> whenSelectedIndexChangedDo: aBlockClosure [ 
	
	self whenSelectionChangedDo: [ :selection | aBlockClosure cull: selection first ]
]

{ #category : #'api-events' }
TableBasePresenter >> whenSelectedItemChangedDo: aBlockClosure [ 
	
	self whenSelectionChangedDo: [ :selection | aBlockClosure cull: selection second ]
]

{ #category : #'api-events' }
TableBasePresenter >> whenSelectionChangedDo: aBlockClosure [ 
	
	selectionHolder whenChangedDo: [ :selectionValueHolderValues | 
		aBlockClosure cull: (selectionValueHolderValues collect: #value) ]
]
