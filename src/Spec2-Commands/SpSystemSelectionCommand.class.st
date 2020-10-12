"
A base for commands working on current text selection.
"
Class {
	#name : #SpSystemSelectionCommand,
	#superclass : #SpSystemNavigationCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #documentation }
SpSystemSelectionCommand class >> documentContextRequiredSelectors [

	^ super documentContextRequiredSelectors, #(selectedTextOrLine)
]

{ #category : #private }
SpSystemSelectionCommand >> evaluate: aString ifError: aBlock [

	^ [
		self class compilerClass new
			environment: self environment;
			class: UndefinedObject;
			source: self selectedTextOrLine;
			evaluate ]
		on: Error 
		do: aBlock
	
]

{ #category : #accessing }
SpSystemSelectionCommand >> selectedTextOrLine [

	^ self context selectedTextOrLine
]
