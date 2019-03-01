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

{ #category : #accessing }
TablePresenter >> items: aSequenceableCollection [

	itemsHolder value: aSequenceableCollection
]

{ #category : #private }
TablePresenter >> itemsChanged [

	self changed: #items
]

{ #category : #api }
TablePresenter >> selectedIndex [
	
	^ selectionHolder index value
]

{ #category : #api }
TablePresenter >> selectedIndex: index [
	| selectedIndex selection |

	selection := self itemAt: index ifAbsent: [ nil ].
	selectedIndex := selection ifNil: [ 0 ].

	selectionHolder index value: selectedIndex.
	selectionHolder selection value: selection.
]

{ #category : #api }
TablePresenter >> selectedItem: anObject [ 
	| index |

	index := self items indexOf: anObject.
	self selectedIndex: index
]
