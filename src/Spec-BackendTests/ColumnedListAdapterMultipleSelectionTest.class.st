Class {
	#name : #ColumnedListAdapterMultipleSelectionTest,
	#superclass : #AbstractListAdapterMultipleSelectionTest,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
ColumnedListAdapterMultipleSelectionTest >> classToTest [
	^ ColumnedListPresenter
]

{ #category : #running }
ColumnedListAdapterMultipleSelectionTest >> initializeTestedInstance [

	super initializeTestedInstance.

	presenter addColumn: (StringTableColumn evaluated: [ :e | e asString ])
]
