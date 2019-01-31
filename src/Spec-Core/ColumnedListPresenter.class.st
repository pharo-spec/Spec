Class {
	#name : #ColumnedListPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'columns',
		'showColumnHeadersHolder',
		'isResizableHolder',
		'selectionHolder',
		'doubleClickActionHolder',
		'itemsHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #specs }
ColumnedListPresenter class >> adapterName [

	^ #TableAdapter
]

{ #category : #api }
ColumnedListPresenter >> addColumn: aColumn [

	columns := columns copyWith: aColumn
]

{ #category : #api }
ColumnedListPresenter >> beNotResizable [
	self isResizable: false
]

{ #category : #api }
ColumnedListPresenter >> beResizable [
	self isResizable: true
]

{ #category : #accessing }
ColumnedListPresenter >> columns [

	^ columns
]

{ #category : #api }
ColumnedListPresenter >> columns: aCollection [

	columns := aCollection
]

{ #category : #'api-events' }
ColumnedListPresenter >> doubleClickAction: aBlockClosure [ 
	
	doubleClickActionHolder value: aBlockClosure
]

{ #category : #simulation }
ColumnedListPresenter >> doubleClickAtIndex: anInteger [ 
	
	self selectedIndex: anInteger.
	doubleClickActionHolder value cull: anInteger
]

{ #category : #api }
ColumnedListPresenter >> hideColumnHeaders [

	showColumnHeadersHolder value: false
]

{ #category : #initialization }
ColumnedListPresenter >> initialize [ 

	super initialize.
	showColumnHeadersHolder := true asValueHolder.
	columns := #().
	isResizableHolder := false asValueHolder.
	selectionHolder := SelectionValueHolder new.
	
	showColumnHeadersHolder whenChangedDo: [ self showColumnHeadersChanged ].

	itemsHolder := #() asValueHolder.
	itemsHolder whenChangedDo: [ self itemsChanged ].	
	
	doubleClickActionHolder := [ ] asValueHolder.
]

{ #category : #accessing }
ColumnedListPresenter >> isResizable [
	^ isResizableHolder value
]

{ #category : #accessing }
ColumnedListPresenter >> isResizable: aBoolean [
	isResizableHolder value: aBoolean
]

{ #category : #testing }
ColumnedListPresenter >> isShowingColumnHeaders [

	^ showColumnHeadersHolder value
]

{ #category : #accessing }
ColumnedListPresenter >> itemAt: aNumber [
	
	^ self items at: aNumber
]

{ #category : #accessing }
ColumnedListPresenter >> items [

	^ itemsHolder value
]

{ #category : #accessing }
ColumnedListPresenter >> items: aSequenceableCollection [

	itemsHolder value: aSequenceableCollection
]

{ #category : #private }
ColumnedListPresenter >> itemsChanged [

	self changed: #items
]

{ #category : #api }
ColumnedListPresenter >> selectedIndex [
	
	^ selectionHolder index value
]

{ #category : #api }
ColumnedListPresenter >> selectedIndex: anIndex [
	
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
ColumnedListPresenter >> selectedItem [
	
	^ selectionHolder selection value
]

{ #category : #api }
ColumnedListPresenter >> selectedItem: anInteger [ 
	
	| index |
	index := self items indexOf: anInteger.
	self selectedIndex: index
]

{ #category : #api }
ColumnedListPresenter >> showColumnHeaders [

	showColumnHeadersHolder value: true
]

{ #category : #private }
ColumnedListPresenter >> showColumnHeadersChanged [

	self changed: #showColumnHeaders
]

{ #category : #'api-events' }
ColumnedListPresenter >> whenIsResizableChangedDo: aBlock [
	isResizableHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
ColumnedListPresenter >> whenSelectedIndexChangedDo: aBlockClosure [ 
	
	self whenSelectionChangedDo: [ :selection | aBlockClosure cull: selection first ]
]

{ #category : #'api-events' }
ColumnedListPresenter >> whenSelectedItemChangedDo: aBlockClosure [ 
	
	self whenSelectionChangedDo: [ :selection | aBlockClosure cull: selection second ]
]

{ #category : #'api-events' }
ColumnedListPresenter >> whenSelectionChangedDo: aBlockClosure [ 
	
	selectionHolder whenChangedDo: [ :selectionValueHolderValues | 
		aBlockClosure cull: (selectionValueHolderValues collect: #value) ]
]
