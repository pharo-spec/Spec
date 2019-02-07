Class {
	#name : #ColumnedListPresenter,
	#superclass : #AbstractListPresenter,
	#instVars : [
		'columns',
		'showColumnHeadersHolder',
		'isResizableHolder',
		'itemsHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #specs }
ColumnedListPresenter class >> adapterName [

	^ #ColumnedListAdapter
]

{ #category : #specs }
ColumnedListPresenter class >> example [
	<sampleInstance>
	| example |
	example := self new.
	example
		addColumn: (StringTableColumn new evaluated: #yourself);
		items: (1 to: 10) asArray;
		openWithSpec.
	^ example
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
	
	showColumnHeadersHolder whenChangedDo: [ self showColumnHeadersChanged ].

	itemsHolder := #() asValueHolder.
	itemsHolder whenChangedDo: [ self itemsChanged ].
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
	
	^ super itemAt: aNumber
]

{ #category : #accessing }
ColumnedListPresenter >> items [

	^ itemsHolder value
]

{ #category : #private }
ColumnedListPresenter >> itemsChanged [

	self changed: #items
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
