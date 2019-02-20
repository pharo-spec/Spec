"
A TablePresenter handles a table.
Tables defines columns (see #addColumn: and TableColumn hierarchy).
Tables receive items (see #items:) to feed the table.

self example

"
Class {
	#name : #TablePresenter,
	#superclass : #TableBasePresenter,
	#instVars : [
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
		addColumn: (ImageTableColumn title: 'Icon' evaluated: #systemIcon);
		addColumn: (StringTableColumn title: 'Name' evaluated: #name);
		items: Smalltalk allClasses;
		doubleClickAction: [ :aClass | self inform: 'Double click on: ', aClass name ];
		openWithSpec
]

{ #category : #example }
TablePresenter class >> exampleEditableCell [

	self flag: #TODO
]

{ #category : #initialization }
TablePresenter >> initialize [ 

	super initialize.
	itemsHolder := #() asValueHolder.
	itemsHolder whenChangedDo: [ self itemsChanged ].	
	
	doubleClickActionHolder := [ ] asValueHolder.
]

{ #category : #accessing }
TablePresenter >> itemAt: aNumber [
	
	^ self items at: aNumber
]

{ #category : #accessing }
TablePresenter >> itemAt: aNumber ifAbsent: aBlock [
	
	^ self items 
		at: aNumber
		ifAbsent: aBlock
]

{ #category : #accessing }
TablePresenter >> items [

	^ itemsHolder value
]

{ #category : #api }
TablePresenter >> items: aSequenceableCollection [

	itemsHolder value: aSequenceableCollection
]

{ #category : #private }
TablePresenter >> itemsChanged [

	self changed: #items
]

{ #category : #api }
TablePresenter >> selectIndex: anIndex [
	"Alias to make the API better."

	self selectedIndex: anIndex
]

{ #category : #api }
TablePresenter >> selectItem: anItem [
	"Alias to make the API better."

	self selectedItem: anItem
]

{ #category : #api }
TablePresenter >> selectedIndex [

	^ selectionHolder index value
]

{ #category : #accessing }
TablePresenter >> selectedIndex: index [
	| selectedIndex selection |

	selection := self itemAt: index ifAbsent: [ nil ].
	selectedIndex := selection ifNil: [ 0 ].

	selectionHolder index value: selectedIndex.
	selectionHolder selection value: selection.
]

{ #category : #api }
TablePresenter >> selectedItem [

	^ selectionHolder selection value
]

{ #category : #accessing }
TablePresenter >> selectedItem: anInteger [ 
	
	| index |
	index := self items indexOf: anInteger.
	self selectedIndex: index
]
