Class {
	#name : #SpMorphicFrameLayout,
	#superclass : #SpMorphicBaseBoxLayout,
	#instVars : [
		'calculating'
	],
	#category : #'Spec2-Adapters-Morphic-Layout'
}

{ #category : #initialization }
SpMorphicFrameLayout >> initialize [

	super initialize.
	calculating := false
]

{ #category : #initialization }
SpMorphicFrameLayout >> isHomogeneous [

	^ false
]

{ #category : #layout }
SpMorphicFrameLayout >> layout: aMorph in: aRect [

	calculating ifTrue: [ ^ self ].
	[
		calculating := true. 
		self isHomogeneous 
			ifTrue: [ self layoutHomogeneous: aMorph in: aRect ].
		super layout: aMorph in: aRect ]
	ensure: [
		calculating := false ]
]
