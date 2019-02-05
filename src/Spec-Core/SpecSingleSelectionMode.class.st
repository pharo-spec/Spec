Class {
	#name : #SpecSingleSelectionMode,
	#superclass : #SpecAbstractSelectionMode,
	#instVars : [
		'selectedIndexValueHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #selecting }
SpecSingleSelectionMode >> basicSelectIndex: indexToSelect [

	selectedIndexValueHolder value: indexToSelect
]

{ #category : #testing }
SpecSingleSelectionMode >> includesIndex: anIndex [

	^ selectedIndexValueHolder value = anIndex
]

{ #category : #testing }
SpecSingleSelectionMode >> includesItem: anItem [

	^ self selectedItem = anItem
]

{ #category : #initialization }
SpecSingleSelectionMode >> initialize [

	super initialize.
	selectedIndexValueHolder := 0 asValueHolder
]

{ #category : #accessing }
SpecSingleSelectionMode >> selectedIndex [
	
	^ selectedIndexValueHolder value
]

{ #category : #accessing }
SpecSingleSelectionMode >> selectedItem [

	self selectedIndex = 0 ifTrue: [ ^ nil ].
	^ self model at: self selectedIndex
]

{ #category : #events }
SpecSingleSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	selectedIndexValueHolder whenChangedDo: [ aBlockClosure value: self ]
]
