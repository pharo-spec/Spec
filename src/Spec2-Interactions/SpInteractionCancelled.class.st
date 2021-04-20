"
I am the error raised when the user cancelled a request.
"
Class {
	#name : #SpInteractionCancelled,
	#superclass : #SpCancelledInteractionError,
	#category : #'Spec2-Interactions'
}

{ #category : #testing }
SpInteractionCancelled class >> isDeprecated [ 
	^ true
]
