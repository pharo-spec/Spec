"
A base for the calculator of sizes of morphs on a box layout.
This is an **ONGOING** refactor of what is found in `TableLayout`, trying to get a better (and more understandable) design.
"
Class {
	#name : 'SpMorphicBoxLayoutCalculator',
	#superclass : 'Object',
	#instVars : [
		'extra',
		'sum',
		'vFill',
		'size',
		'minX',
		'maxX',
		'minY',
		'maxY',
		'width',
		'height',
		'properties',
		'number',
		'firstCell',
		'lastCell'
	],
	#category : 'Spec2-Adapters-Morphic-Layout',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Layout'
}

{ #category : 'instance creation' }
SpMorphicBoxLayoutCalculator class >> newProperties: anObject [

	^ self basicNew 
		initializeProperties: anObject;
		yourself
]

{ #category : 'calculating' }
SpMorphicBoxLayoutCalculator >> calculateFor: aMorph in: newBounds [

	self subclassResponsibility
]

{ #category : 'initialization' }
SpMorphicBoxLayoutCalculator >> initializeProperties: anObject [

	self initialize.
	properties := anObject
]
