"
I define a double click event
"
Class {
	#name : 'SpMouseDoubleClickDefinition',
	#superclass : 'SpBaseEventDefinition',
	#category : 'Spec2-Core-Base-Event',
	#package : 'Spec2-Core',
	#tag : 'Base-Event'
}

{ #category : 'installing' }
SpMouseDoubleClickDefinition >> installOn: anAdapter target: aWidget [

	anAdapter installMouseDoubleClickEvent: self to: aWidget
]
