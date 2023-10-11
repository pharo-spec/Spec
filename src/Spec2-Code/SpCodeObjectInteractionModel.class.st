Class {
	#name : 'SpCodeObjectInteractionModel',
	#superclass : 'SpCodeInteractionModel',
	#instVars : [
		'object'
	],
	#category : 'Spec2-Code-Base',
	#package : 'Spec2-Code',
	#tag : 'Base'
}

{ #category : 'instance creation' }
SpCodeObjectInteractionModel class >> on: anObject [

	^ self new object: anObject
]

{ #category : 'accessing' }
SpCodeObjectInteractionModel >> behavior [

	^ self object class
]

{ #category : 'binding' }
SpCodeObjectInteractionModel >> bindingOf: aString [
	^ nil
]

{ #category : 'accessing' }
SpCodeObjectInteractionModel >> doItReceiver [

	^ self object
]

{ #category : 'binding' }
SpCodeObjectInteractionModel >> hasBindingOf: aString [
	^ false
]

{ #category : 'testing' }
SpCodeObjectInteractionModel >> isScripting [

	^ true
]

{ #category : 'accessing' }
SpCodeObjectInteractionModel >> object [

	^ object
]

{ #category : 'accessing' }
SpCodeObjectInteractionModel >> object: anObject [

	object := anObject
]
