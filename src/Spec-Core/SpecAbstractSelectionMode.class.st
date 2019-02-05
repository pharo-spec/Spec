Class {
	#name : #SpecAbstractSelectionMode,
	#superclass : #Object,
	#instVars : [
		'model'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #'instance creation' }
SpecAbstractSelectionMode class >> on: aModel [

	^ self new
		model: aModel;
		yourself
]

{ #category : #selecting }
SpecAbstractSelectionMode >> basicSelectIndex: indexToSelect item: valueToSelect [

	self subclassResponsibility
]

{ #category : #testing }
SpecAbstractSelectionMode >> includesIndex: anIndex [

	self subclassResponsibility
]

{ #category : #testing }
SpecAbstractSelectionMode >> includesItem: anItem [

	self subclassResponsibility
]

{ #category : #testing }
SpecAbstractSelectionMode >> isMultipleSelection [
	
	^ false
]

{ #category : #accessing }
SpecAbstractSelectionMode >> model [
	^ model
]

{ #category : #accessing }
SpecAbstractSelectionMode >> model: anObject [
	model := anObject
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
