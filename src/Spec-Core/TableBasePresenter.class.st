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
		'isResizableHolder'
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
