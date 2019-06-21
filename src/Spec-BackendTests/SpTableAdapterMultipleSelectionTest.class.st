Class {
	#name : #SpTableAdapterMultipleSelectionTest,
	#superclass : #SpAbstractListAdapterMultipleSelectionTest,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
SpTableAdapterMultipleSelectionTest >> classToTest [
	^ SpTablePresenter
]

{ #category : #running }
SpTableAdapterMultipleSelectionTest >> initializeTestedInstance [

	super initializeTestedInstance.

	presenter addColumn: (StringTableColumn evaluated: [ :e | e asString ])
]
