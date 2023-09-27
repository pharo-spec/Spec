"
I define a mouse move event
"
Class {
	#name : 'SpMouseMoveEventDefinition',
	#superclass : 'SpBaseEventDefinition',
	#category : 'Spec2-Core-Base-Event',
	#package : 'Spec2-Core',
	#tag : 'Base-Event'
}

{ #category : 'installing' }
SpMouseMoveEventDefinition >> installOn: anAdapter target: aWidget [

	anAdapter installMouseMoveEvent: self to: aWidget
]
