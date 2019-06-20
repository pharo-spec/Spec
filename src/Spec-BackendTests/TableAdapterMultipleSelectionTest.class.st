Class {
	#name : #TableAdapterMultipleSelectionTest,
	#superclass : #AbstractListAdapterMultipleSelectionTest,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
TableAdapterMultipleSelectionTest >> classToTest [
	^ SpTablePresenter
]

{ #category : #running }
TableAdapterMultipleSelectionTest >> initializeTestedInstance [

	super initializeTestedInstance.

	presenter addColumn: (StringTableColumn evaluated: [ :e | e asString ])
]
