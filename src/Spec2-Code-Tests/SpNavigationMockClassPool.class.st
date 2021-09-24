Class {
	#name : #SpNavigationMockClassPool,
	#superclass : #SharedPool,
	#classVars : [
		'SomeClassPoolVariable'
	],
	#category : #'Spec2-Code-Tests'
}

{ #category : #'as yet unclassified' }
SpNavigationMockClassPool >> referenceToTheClassVariable [

	^ SomeClassVariable
]

{ #category : #'as yet unclassified' }
SpNavigationMockClassPool >> referenceToYourself [

	^ SpNavigationMockClass
]
