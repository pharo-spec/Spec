"
An activation container to simulate a selection object (the object that is sent when a selection is triggered on `activation` and `selection` events). 
This is used so we can trigger `activation` events outside lists tables and trees (for example, in a playground or an inpector evaluator).
"
Class {
	#name : #SpActivatedObject,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Spec2-Transmission-Custom'
}

{ #category : #'instance creation' }
SpActivatedObject class >> newValue: anObject [ 

	^ self new
		value: anObject;
		yourself
]

{ #category : #'api - selection' }
SpActivatedObject >> selectedItem [

	^ self value
]

{ #category : #accessing }
SpActivatedObject >> transmission [

	^ self value
]

{ #category : #accessing }
SpActivatedObject >> value [

	^ value
]

{ #category : #accessing }
SpActivatedObject >> value: anObject [

	value := anObject
]
