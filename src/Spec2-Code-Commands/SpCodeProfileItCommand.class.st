"
I'm a ""profile it"" command. 
I will evalute the selection (or line) of the playground using a profiler.
"
Class {
	#name : 'SpCodeProfileItCommand',
	#superclass : 'SpCodeSelectionCommand',
	#category : 'Spec2-Code-Commands-TODO',
	#package : 'Spec2-Code-Commands',
	#tag : 'TODO'
}

{ #category : 'defaults' }
SpCodeProfileItCommand class >> defaultIconName [

	^ #smallProfile
]

{ #category : 'defaults' }
SpCodeProfileItCommand class >> defaultName [

	^ 'Profile it'
]

{ #category : 'execution' }
SpCodeProfileItCommand >> execute [

	self flag: 'TODO'
]
