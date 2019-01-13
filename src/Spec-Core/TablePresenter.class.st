"
A TablePresenter handles a table.
Tables defines columns (see #addColumn: and TableColumn hierarchy).
Tables receive items (see #items:) to feed the table.

self example

"
Class {
	#name : #TablePresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'columns',
		'itemsHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #specs }
TablePresenter class >> adapterName [

	^ #TableAdapter
]

{ #category : #example }
TablePresenter class >> example [
	<sampleInstance>
	
	^ self new
		addColumn: (ImageTableColumn new 
			title: 'Icon';
			evaluated: #systemIcon;
			yourself);
		addColumn: (StringTableColumn new 
			title: 'Name';
			evaluated: #name;
			yourself);
		items: Smalltalk allClasses;
		openWithSpec
]

{ #category : #example }
TablePresenter class >> exampleEditableCell [

	self flag: #TODO
]

{ #category : #accessing }
TablePresenter >> addColumn: aColumn [

	columns := columns copyWith: aColumn
]

{ #category : #accessing }
TablePresenter >> columns [
	^ columns
]

{ #category : #accessing }
TablePresenter >> columns: aCollection [

	columns := aCollection
]

{ #category : #initialization }
TablePresenter >> initialize [ 

	super initialize.
	columns := #().
	itemsHolder := #() asValueHolder.
	
	itemsHolder whenChangedDo: [ self itemsChanged ].
]

{ #category : #accessing }
TablePresenter >> itemAt: aNumber [
	
	^ self items at: aNumber
]

{ #category : #accessing }
TablePresenter >> items [

	^ itemsHolder value
]

{ #category : #accessing }
TablePresenter >> items: aSequenceableCollection [

	itemsHolder value: aSequenceableCollection
]

{ #category : #private }
TablePresenter >> itemsChanged [

	self changed: #items
]
