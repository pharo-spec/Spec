"
I am a command to protect given variables
"
Class {
	#name : 'StProtectVariableCommand',
	#superclass : 'StRefactoringVariableCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'default' }
StProtectVariableCommand class >> defaultDescription [

	^ 'Inline all calls of accessors of selected instance variable'
]

{ #category : 'accessing' }
StProtectVariableCommand class >> defaultIconName [

	^ #group
]

{ #category : 'default' }
StProtectVariableCommand class >> defaultName [

	^ '(R) Protect'
]

{ #category : 'executing' }
StProtectVariableCommand >> prepareDriver [

	^ (ReProtectInstanceVariableDriver newApplication: self application)
		  scopes: context allScopes
		  variable: self codePresenter selectedNode variable
		  class: self codePresenter behavior
]
