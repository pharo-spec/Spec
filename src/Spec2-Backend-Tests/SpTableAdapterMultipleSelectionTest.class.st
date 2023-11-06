Class {
	#name : 'SpTableAdapterMultipleSelectionTest',
	#superclass : 'SpAbstractListAdapterMultipleSelectionTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpTableAdapterMultipleSelectionTest >> classToTest [
	^ SpTablePresenter
]

{ #category : 'initialization' }
SpTableAdapterMultipleSelectionTest >> initializeTestedInstance [

	super initializeTestedInstance.

	presenter addColumn: (SpStringTableColumn evaluated: [ :e | e ])
]
