"
I'm a simple object to wrap a selected item for an `SpActivationTransform`.
"
Class {
	#name : #SpActivatedSelection,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Spec2-Core-Support'
}

{ #category : #'instance creation' }
SpActivatedSelection class >> newValue: anObject [

	^ self new 
		value: anObject;
		yourself
]

{ #category : #accessing }
SpActivatedSelection >> selectedItem [

	^ value
]

{ #category : #accessing }
SpActivatedSelection >> value [

	^ value
]

{ #category : #accessing }
SpActivatedSelection >> value: anObject [

	value := anObject
]
