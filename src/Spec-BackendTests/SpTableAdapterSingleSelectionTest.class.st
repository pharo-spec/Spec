Class {
	#name : #SpTableAdapterSingleSelectionTest,
	#superclass : #SpAbstractListAdapterSingleSelectionTest,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
SpTableAdapterSingleSelectionTest >> classToTest [
	^ SpTablePresenter
]

{ #category : #running }
SpTableAdapterSingleSelectionTest >> initializeTestedInstance [ 

	super initializeTestedInstance.
	presenter addColumn: (SpStringTableColumn evaluated: [:e | e displayString]).
]
