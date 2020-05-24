Class {
	#name : #SpCodeObjectInteractionModel,
	#superclass : #SpCodeInteractionModel,
	#instVars : [
		'object'
	],
	#category : #'Spec2-Code'
}

{ #category : #'instance creation' }
SpCodeObjectInteractionModel class >> on: anObject [

	^ self new object: anObject
]

{ #category : #accessing }
SpCodeObjectInteractionModel >> bindings [

	^ bindings ifNil: [ bindings := self collectBindings ]
	
]

{ #category : #private }
SpCodeObjectInteractionModel >> collectBindings [
	| newBindings |
	
	newBindings := Dictionary new.
	self behavior slots do: [ :each |
		newBindings at: each name put: (each read: self object) ].
	^ newBindings
]

{ #category : #accessing }
SpCodeObjectInteractionModel >> doItReceiver [

	^ self object
]

{ #category : #testing }
SpCodeObjectInteractionModel >> isForScripting [

	^ true
]

{ #category : #accessing }
SpCodeObjectInteractionModel >> object [

	^ object
]

{ #category : #accessing }
SpCodeObjectInteractionModel >> object: anObject [

	object := anObject.
	bindings := nil
]
