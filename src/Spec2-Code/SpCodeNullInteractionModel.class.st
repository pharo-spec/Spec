Class {
	#name : 'SpCodeNullInteractionModel',
	#superclass : 'SpCodeInteractionModel',
	#category : 'Spec2-Code-Base',
	#package : 'Spec2-Code',
	#tag : 'Base'
}

{ #category : 'binding' }
SpCodeNullInteractionModel >> bindingOf: aString [
	^ nil
]

{ #category : 'binding' }
SpCodeNullInteractionModel >> hasBindingOf: aString [
	^ false
]
