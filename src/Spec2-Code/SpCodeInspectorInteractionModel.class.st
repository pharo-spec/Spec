Class {
	#name : #SpCodeInspectorInteractionModel,
	#superclass : #SpCodeInteractionModel,
	#instVars : [
		'object'
	],
	#category : #'Spec2-Code'
}

{ #category : #'instance creation' }
SpCodeInspectorInteractionModel class >> on: anObject [

	^ self new object: anObject
]

{ #category : #accessing }
SpCodeInspectorInteractionModel >> behavior [

	^ self object class
]

{ #category : #accessing }
SpCodeInspectorInteractionModel >> bindings [

	^ bindings ifNil: [ bindings := self collectBindings ]
	
]

{ #category : #private }
SpCodeInspectorInteractionModel >> collectBindings [
	| newBindings |
	
	newBindings := Dictionary new.
	self behavior slots do: [ :each |
		newBindings at: each name put: (each read: self object) ].
	^ newBindings
]

{ #category : #accessing }
SpCodeInspectorInteractionModel >> doItReceiver [

	^ self object
]

{ #category : #testing }
SpCodeInspectorInteractionModel >> isForScripting [

	^ true
]

{ #category : #accessing }
SpCodeInspectorInteractionModel >> object [

	^ object
]

{ #category : #accessing }
SpCodeInspectorInteractionModel >> object: anObject [

	object := anObject.
	bindings := nil
]
