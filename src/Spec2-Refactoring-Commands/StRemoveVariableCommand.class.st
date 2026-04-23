"
I am a command that is used for removing variables.

My responsibility is to delegate removal execution to the remove variable driver.
"
Class {
	#name : 'StRemoveVariableCommand',
	#superclass : 'StRefactoringVariableCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'default' }
StRemoveVariableCommand class >> defaultDescription [

	^ 'Remove selected variable'
]

{ #category : 'accessing' }
StRemoveVariableCommand class >> defaultIconName [

	^ #remove
]

{ #category : 'default' }
StRemoveVariableCommand class >> defaultName [

	^ '(R) Remove'
]

{ #category : 'executing' }
StRemoveVariableCommand >> prepareDriver [

	self codePresenter selectedNode variable isClassVariable
		ifFalse: [
				^ ReRemoveInstanceVariablesDriver new
					  scopes: context allScopes
					  variables: { self codePresenter selectedNode variable name }
					  for: self codePresenter behavior ]
		ifTrue: [
				^ ReRemoveSharedVariablesDriver new
					  scopes: context allScopes
					  variables: { self codePresenter selectedNode variable name }
					  for: self codePresenter behavior ]
]
