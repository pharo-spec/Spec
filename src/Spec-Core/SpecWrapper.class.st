"
I am a small wrapper used to encapsulate data created and used during spec interpretation
"
Class {
	#name : #SpecWrapper,
	#superclass : #Object,
	#instVars : [
		'instance'
	],
	#category : #'Spec-Core-Utilities'
}

{ #category : #'instance creation' }
SpecWrapper class >> instance: instance [

	^ self new
		instance: instance;
		yourself
]

{ #category : #accessing }
SpecWrapper >> instance [
	
	^ instance
]

{ #category : #accessing }
SpecWrapper >> instance: anObject [
	
	instance := anObject
]

{ #category : #protocol }
SpecWrapper >> isRedrawable [
	
	^ self instance isRedrawable
]

{ #category : #protocol }
SpecWrapper >> removeSubWidgets [
	
	^ self instance removeSubWidgets
]
