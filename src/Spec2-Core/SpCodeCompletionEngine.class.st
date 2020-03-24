"
I'm a code completion engine.
I can have several configurations: 

- I have a completionClass, and I am not for scripting -> I will be used in a browser.
- I have a completionClass, and I am for scripting -> I will be used in an inspector.
- I do not have a completionClass, and I am not for scripting -> I am in a method without class
- I do not have a completionClass, and I am for scription -> I will be used in a workspace (playground)

"
Class {
	#name : #SpCodeCompletionEngine,
	#superclass : #CoCompletionEngine,
	#instVars : [
		'scripting',
		'completionClass',
		'doItContext',
		'doItRequestor'
	],
	#category : #'Spec2-Core-Widgets-Text'
}

{ #category : #accessing }
SpCodeCompletionEngine >> completionClass: anObject [

	completionClass := anObject
]
