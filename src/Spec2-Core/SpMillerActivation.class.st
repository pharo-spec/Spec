Class {
	#name : 'SpMillerActivation',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'Spec2-Core-Miller',
	#package : 'Spec2-Core',
	#tag : 'Miller'
}

{ #category : 'instance creation' }
SpMillerActivation class >> on: anInteger [ 
	
	^ self new
		value: anInteger;
		yourself
]

{ #category : 'accessing' }
SpMillerActivation >> selectedItem [
	
	^ value
]

{ #category : 'accessing' }
SpMillerActivation >> value: anInteger [ 
	value := anInteger
]
