"
I define a key down event
"
Class {
	#name : 'SpMouseLeaveEventDefinition',
	#superclass : 'SpBaseEventDefinition',
	#category : 'Spec2-Core-Base-Event',
	#package : 'Spec2-Core',
	#tag : 'Base-Event'
}

{ #category : 'installing' }
SpMouseLeaveEventDefinition >> installOn: anAdapter target: aWidget [

	anAdapter installMouseLeaveEvent: self to: aWidget
]
