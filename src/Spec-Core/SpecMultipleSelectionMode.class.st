Class {
	#name : #SpecMultipleSelectionMode,
	#superclass : #SpecAbstractSelectionMode,
	#instVars : [
		'selectedIndexesValueHolder',
		'selectedItemsValueHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #selecting }
SpecMultipleSelectionMode >> basicSelectIndex: indexToSelect item: valueToSelect [

	"Adding to the selection an out of range should not change selection"
	indexToSelect = 0 ifTrue: [ ^ self ].

	selectedIndexesValueHolder value: (selectedIndexesValueHolder value copyWith: indexToSelect).
	selectedItemsValueHolder value: (selectedIndexesValueHolder value copyWith: valueToSelect).
]

{ #category : #selecting }
SpecMultipleSelectionMode >> initialize [

	super initialize.
	selectedIndexesValueHolder := OrderedCollection new asValueHolder.
	selectedItemsValueHolder := OrderedCollection new asValueHolder.
]

{ #category : #selecting }
SpecMultipleSelectionMode >> isEmpty [ 
	^ selectedIndexesValueHolder value isEmpty
]

{ #category : #events }
SpecMultipleSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	selectedIndexesValueHolder whenChangedDo: [ aBlockClosure value: self ].
	selectedItemsValueHolder whenChangedDo: [ aBlockClosure value: self ].
]
