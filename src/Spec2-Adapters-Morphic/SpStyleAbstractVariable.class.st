Class {
	#name : #SpStyleAbstractVariable,
	#superclass : #Object,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #converting }
SpStyleAbstractVariable >> asStyleVariable [

	^ self
]

{ #category : #testing }
SpStyleAbstractVariable >> isEnvironmentVariable [

	^ false
]

{ #category : #evaluating }
SpStyleAbstractVariable >> preferredValueWith: anObject [

	^ self value
]

{ #category : #evaluating }
SpStyleAbstractVariable >> value [

	^ self subclassResponsibility
]
