Class {
	#name : #ColumnedListAdapterSingleSelectionTest,
	#superclass : #AbstractListAdapterSingleSelectionTest,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
ColumnedListAdapterSingleSelectionTest >> classToTest [
	^ ColumnedListPresenter
]

{ #category : #running }
ColumnedListAdapterSingleSelectionTest >> initializeTestedInstance [ 

	super initializeTestedInstance.
	presenter addColumn: (StringTableColumn evaluated: [:e | e displayString]).
]
