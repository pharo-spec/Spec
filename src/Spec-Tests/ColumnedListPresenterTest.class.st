Class {
	#name : #ColumnedListPresenterTest,
	#superclass : #AbstractListPresenterTest,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
ColumnedListPresenterTest >> classToTest [
	
	^ ColumnedListPresenter
]

{ #category : #'tests-activation' }
ColumnedListPresenterTest >> testAddColumnRaisesColumnChangedEvent [

	| columnsChanged |
	columnsChanged := false.
	presenter whenColumnsChangedDo: [ columnsChanged := true ].

	presenter addColumn: (StringTableColumn new evaluated: #yourself).
	
	self assert: columnsChanged
]
