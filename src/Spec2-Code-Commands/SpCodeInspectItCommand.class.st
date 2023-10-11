"
I'm an ""inspect it"" command. 
I will execute the selection (or line) of the playground and inspect the result.
"
Class {
	#name : 'SpCodeInspectItCommand',
	#superclass : 'SpCodeSelectionCommand',
	#category : 'Spec2-Code-Commands-Base',
	#package : 'Spec2-Code-Commands',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpCodeInspectItCommand class >> defaultDescription [

	^ 'Evaluate selection and inspect the result.'
]

{ #category : 'defaults' }
SpCodeInspectItCommand class >> defaultIconName [

	^ #smallInspectIt
]

{ #category : 'default' }
SpCodeInspectItCommand class >> defaultName [

	^ 'Inspect it'
]

{ #category : 'default' }
SpCodeInspectItCommand class >> defaultShortcutKey [

	^ $i command mac 
		| $i control win
		| $i control unix
]

{ #category : 'documentation' }
SpCodeInspectItCommand class >> documentContextRequiredSelectors [

	^ super documentContextRequiredSelectors, #(systemNavigation)
]

{ #category : 'execution' }
SpCodeInspectItCommand >> execute [
	"Treat the current text selection as an expression; evaluate it."
	
	self evaluateSelectionAndDo: [ :result | 
		self inspectObject: result ]
]

{ #category : 'private - actions' }
SpCodeInspectItCommand >> inspectObject: anObject [

	self context systemNavigation inspect: anObject
]
