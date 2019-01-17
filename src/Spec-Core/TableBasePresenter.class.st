"
I'm a base presenter for tables (simple tables and trees).
I define common members for my children.

"
Class {
	#name : #TableBasePresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'columns',
		'showColumnHeadersHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #accessing }
TableBasePresenter >> addColumn: aColumn [

	columns := columns copyWith: aColumn
]

{ #category : #accessing }
TableBasePresenter >> columns [

	^ columns
]

{ #category : #accessing }
TableBasePresenter >> columns: aCollection [

	columns := aCollection
]

{ #category : #accessing }
TableBasePresenter >> hideColumnHeaders [

	showColumnHeadersHolder value: false
]

{ #category : #initialization }
TableBasePresenter >> initialize [ 

	super initialize.
	showColumnHeadersHolder := true asValueHolder.
	columns := #().
	
	showColumnHeadersHolder whenChangedDo: [ self showColumnHeadersChanged ]
]

{ #category : #testing }
TableBasePresenter >> isShowingColumnHeaders [

	^ showColumnHeadersHolder value
]

{ #category : #accessing }
TableBasePresenter >> showColumnHeaders [

	showColumnHeadersHolder value: true
]

{ #category : #private }
TableBasePresenter >> showColumnHeadersChanged [

	self changed: #showColumnHeaders
]
