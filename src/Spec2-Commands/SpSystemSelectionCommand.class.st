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

{ #category : #accessing }
SpSystemSelectionCommand >> selectedTextOrLine [

	^ self context selectedTextOrLine
]
