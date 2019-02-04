Class {
	#name : #SpecSingleSelectionMode,
	#superclass : #Object,
	#instVars : [
		'selectedIndexValueHolder',
		'selectedItemValueHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

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

{ #category : #selecting }
SpecSingleSelectionMode >> selectIndex: anIndex on: aListPresenter [ 
	
	| indexToSelect valueToSelect |
	indexToSelect := anIndex.
	valueToSelect := aListPresenter model
		at: indexToSelect
		ifAbsent: [ 
			indexToSelect := 0.
			nil ].
	
	selectedIndexValueHolder value: indexToSelect.
	selectedItemValueHolder value: valueToSelect.
]

{ #category : #selecting }
SpecSingleSelectionMode >> selectItem: anItem on: aListPresenter [ 
	
	| indexToSelect valueToSelect |
	valueToSelect := anItem.
	indexToSelect := aListPresenter model
		indexOf: valueToSelect
		ifAbsent: [ 
			valueToSelect := nil.
			0 ].
	
	selectedIndexValueHolder value: indexToSelect.
	selectedItemValueHolder value: valueToSelect.
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
