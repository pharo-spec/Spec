Class {
	#name : #TreeSingleSelectionMode,
	#superclass : #Object,
	#traits : 'TSpecObservable',
	#classTraits : 'TSpecObservable classTrait',
	#instVars : [
		'#selection => SpecObservableSlot'
	],
	#category : #'Spec-Core-Widgets-Tree'
}

{ #category : #initialization }
TreeSingleSelectionMode >> initialize [
	self class initializeSlots: self.
	super initialize.

]

{ #category : #testing }
TreeSingleSelectionMode >> isEmpty [
	
	^ selection isNil 
]

{ #category : #accessing }
TreeSingleSelectionMode >> selectedPath [
	
	^ selection
]

{ #category : #accessing }
TreeSingleSelectionMode >> selectedPath: aPath [
	
	selection := aPath.

]

{ #category : #'API - events' }
TreeSingleSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	self property: #selection whenChangedDo: aBlockClosure 
]
