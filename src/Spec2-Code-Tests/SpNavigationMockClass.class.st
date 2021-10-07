Class {
	#name : #SpNavigationMockClass,
	#superclass : #Object,
	#classVars : [
		'SomeClassVariable'
	],
	#pools : [
		'SpNavigationMockClassPool'
	],
	#category : #'Spec2-Code-Tests'
}

{ #category : #mock }
SpNavigationMockClass >> referenceToTheClassPoolVariable [

	^ SomeClassPoolVariable
]

{ #category : #mock }
SpNavigationMockClass >> referenceToTheClassVariable [

	^ SomeClassVariable
]

{ #category : #mock }
SpNavigationMockClass >> referenceToYourself [

	^ SpNavigationMockClass
]
