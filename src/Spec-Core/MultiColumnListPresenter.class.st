"
A MultiColumnListPresenter is a spec presenter for Multi columns list
"
Class {
	#name : #MultiColumnListPresenter,
	#superclass : #ColumnedListPresenter,
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
MultiColumnListPresenter class >> adapterName [

	^ #MultiColumnListAdapter
]

{ #category : #specs }
MultiColumnListPresenter class >> example [
	<sampleInstance>
	| example |
	example := self new.
	example
		icons: [ :e | example iconNamed: #forwardIcon ];
		items: (1 to: 10) asArray;
		openWithSpec.
	^ example
]
