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
