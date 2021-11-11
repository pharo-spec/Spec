Class {
	#name : #SpNavigationMockClassPool,
	#superclass : #SharedPool,
	#classVars : [
		'SomeClassPoolVariable'
	],
	#category : #'Spec2-Code-Tests'
}

{ #category : #mock }
SpNavigationMockClassPool >> referenceToYourself [

	^ SpNavigationMockClass
]
