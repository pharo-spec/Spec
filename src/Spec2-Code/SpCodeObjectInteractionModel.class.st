Class {
	#name : #SpCodeObjectInteractionModel,
	#superclass : #SpCodeInteractionModel,
	#instVars : [
		'object'
	],
	#category : #'Spec2-Code-Base'
}

{ #category : #'instance creation' }
SpCodeObjectInteractionModel class >> on: anObject [

	^ self new object: anObject
]

{ #category : #accessing }
SpCodeObjectInteractionModel >> behavior [

	^ self object class
]

{ #category : #accessing }
SpCodeObjectInteractionModel >> doItReceiver [

	^ self object
]

{ #category : #testing }
SpCodeObjectInteractionModel >> isForScripting [

	^ true
]

{ #category : #testing }
SpCodeObjectInteractionModel >> isScripting [

	^ true
]

{ #category : #accessing }
SpCodeObjectInteractionModel >> object [

	^ object
]

{ #category : #accessing }
SpCodeObjectInteractionModel >> object: anObject [

	object := anObject
]
