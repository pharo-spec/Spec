Class {
	#name : #TableBasePresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'columns'
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

{ #category : #initialization }
TableBasePresenter >> initialize [ 

	super initialize.
	columns := #()
]
