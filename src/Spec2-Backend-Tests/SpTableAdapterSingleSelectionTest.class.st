Class {
	#name : #SpTableAdapterSingleSelectionTest,
	#superclass : #SpAbstractListAdapterSingleSelectionTest,
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #accessing }
SpTableAdapterSingleSelectionTest >> classToTest [
	^ SpTablePresenter
]

{ #category : #initialization }
SpTableAdapterSingleSelectionTest >> initializeTestedInstance [ 

	super initializeTestedInstance.
	presenter addColumn: (SpStringTableColumn evaluated: [:e | e displayString]).
]
