Class {
	#name : #SpecAbstractSelectionMode,
	#superclass : #Object,
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #selecting }
SpecAbstractSelectionMode >> basicSelectIndex: indexToSelect item: valueToSelect [

	self subclassResponsibility
]

{ #category : #testing }
SpecAbstractSelectionMode >> includesIndex: anIndex [

	self subclassResponsibility
]

{ #category : #selecting }
SpecAbstractSelectionMode >> selectIndex: anIndex on: aListPresenter [ 
	
	| indexToSelect valueToSelect |
	indexToSelect := anIndex.
	valueToSelect := aListPresenter model
		at: indexToSelect
		ifAbsent: [ 
			indexToSelect := 0.
			nil ].
	
	self basicSelectIndex: indexToSelect item: valueToSelect
]

{ #category : #selecting }
SpecAbstractSelectionMode >> selectItem: anItem on: aListPresenter [ 
	
	| indexToSelect valueToSelect |
	valueToSelect := anItem.
	indexToSelect := aListPresenter model
		indexOf: valueToSelect
		ifAbsent: [ 
			valueToSelect := nil.
			0 ].
	
	self basicSelectIndex: indexToSelect item: valueToSelect
]

{ #category : #events }
SpecAbstractSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	self subclassResponsibility
]
