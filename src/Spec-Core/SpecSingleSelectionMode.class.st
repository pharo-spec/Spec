Class {
	#name : #SpecSingleSelectionMode,
	#superclass : #SpecAbstractSelectionMode,
	#instVars : [
		'selectedIndexValueHolder',
		'selectedItemValueHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #selecting }
SpecSingleSelectionMode >> basicSelectIndex: indexToSelect item: valueToSelect [

	selectedIndexValueHolder value: indexToSelect.
	selectedItemValueHolder value: valueToSelect.
]

{ #category : #testing }
SpecSingleSelectionMode >> includesIndex: anIndex [

	^ selectedIndexValueHolder value = anIndex
]

{ #category : #initialization }
SpecSingleSelectionMode >> initialize [

	super initialize.
	selectedIndexValueHolder := 0 asValueHolder.
	selectedItemValueHolder := nil asValueHolder.
]

{ #category : #accessing }
SpecSingleSelectionMode >> selectedIndex [
	
	^ selectedIndexValueHolder value
]

{ #category : #accessing }
SpecSingleSelectionMode >> selectedItem [

	^ selectedItemValueHolder value
]

{ #category : #events }
SpecSingleSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	selectedIndexValueHolder whenChangedDo: [ aBlockClosure value: self ].
	selectedItemValueHolder whenChangedDo: [ aBlockClosure value: self ].
]
