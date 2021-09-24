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

{ #category : #'as yet unclassified' }
SpNavigationMockClass >> referenceToTheClassPoolVariable [

	^ SomeClassPoolVariable
]

{ #category : #'as yet unclassified' }
SpNavigationMockClass >> referenceToTheClassVariable [

	^ SomeClassVariable
]

{ #category : #'as yet unclassified' }
SpNavigationMockClass >> referenceToYourself [

	^ SpNavigationMockClass
]
