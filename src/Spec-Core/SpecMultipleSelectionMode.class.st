Class {
	#name : #SpecMultipleSelectionMode,
	#superclass : #SpecAbstractSelectionMode,
	#instVars : [
		'selectedIndexesValueHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #selecting }
SpecMultipleSelectionMode >> basicSelectIndex: indexToSelect item: valueToSelect [

	"Adding to the selection an out of range should not change selection"
	indexToSelect = 0 ifTrue: [ ^ self ].

	selectedIndexesValueHolder value: (selectedIndexesValueHolder value copyWith: indexToSelect)
]

{ #category : #testing }
SpecMultipleSelectionMode >> includesIndex: anIndex [

	^ self selectedIndexes includes: anIndex
]

{ #category : #testing }
SpecMultipleSelectionMode >> includesItem: anItem [

	^ self selectedItems includes: anItem
]

{ #category : #selecting }
SpecMultipleSelectionMode >> initialize [

	super initialize.
	selectedIndexesValueHolder := OrderedCollection new asValueHolder
]

{ #category : #selecting }
SpecMultipleSelectionMode >> isEmpty [ 
	^ selectedIndexesValueHolder value isEmpty
]

{ #category : #testing }
SpecMultipleSelectionMode >> isMultipleSelection [
	
	^ true
]

{ #category : #accessing }
SpecMultipleSelectionMode >> selectedIndexes [

	^ selectedIndexesValueHolder value
]

{ #category : #accessing }
SpecMultipleSelectionMode >> selectedItems [

	^ self selectedIndexes collect: [ :idx | model itemAt: idx ].
]

{ #category : #events }
SpecMultipleSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	selectedIndexesValueHolder whenChangedDo: [ aBlockClosure value: self ]
]
