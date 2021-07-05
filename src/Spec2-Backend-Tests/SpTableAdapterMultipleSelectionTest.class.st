Class {
	#name : #SpTableAdapterMultipleSelectionTest,
	#superclass : #SpAbstractListAdapterMultipleSelectionTest,
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #accessing }
SpTableAdapterMultipleSelectionTest >> classToTest [
	^ SpTablePresenter
]

{ #category : #initialization }
SpTableAdapterMultipleSelectionTest >> initializeTestedInstance [

	super initializeTestedInstance.

	presenter addColumn: (SpStringTableColumn evaluated: [ :e | e ])
]
