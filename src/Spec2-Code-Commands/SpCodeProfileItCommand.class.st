"
I'm a ""profile it"" command. 
I will evalute the selection (or line) of the playground using a profiler.
"
Class {
	#name : 'SpCodeProfileItCommand',
	#superclass : 'SpCodeSelectionCommand',
	#category : 'Spec2-Code-Commands-Base',
	#package : 'Spec2-Code-Commands',
	#tag : 'Base'
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

	| selection receiver evaluationContext stream compiledMethod |
	selection := self selectedTextOrLine.
	selection trimBoth ifEmpty: [ ^ self ].

	receiver := self context doItReceiver.
	evaluationContext := self context doItContext.

	stream := selection readStream.
	compiledMethod := self
		                  compile: stream
		                  for: receiver
		                  in: evaluationContext.
	compiledMethod ifNil: [ ^ self ].

	ProfilerPresenter new
		open;
		profileBlock: [
			compiledMethod valueWithReceiver: receiver arguments: #(  ) ]
		displayCode: selection
]

{ #category : 'constants' }
SpCodeProfileItCommand >> profilerPresenterClass [

	^ ProfilerPresenter
]
