Class {
	#name : #SpCodeNullInteractionModel,
	#superclass : #SpCodeInteractionModel,
	#category : #'Spec2-Code-Base'
}

{ #category : #binding }
SpCodeNullInteractionModel >> bindingOf: aString [

	^ nil
]

{ #category : #testing }
SpCodeNullInteractionModel >> hasBindingOf: aString [

	^ false
]
