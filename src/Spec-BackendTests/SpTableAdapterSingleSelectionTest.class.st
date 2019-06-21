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
	presenter addColumn: (StringTableColumn evaluated: [:e | e displayString]).
]
