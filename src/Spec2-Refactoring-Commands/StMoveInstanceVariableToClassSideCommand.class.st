"
I am a command to move given instance variable to its class side
"
Class {
	#name : 'StMoveInstanceVariableToClassSideCommand',
	#superclass : 'StRefactoringCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'default' }
StMoveInstanceVariableToClassSideCommand class >> defaultDescription [

	^ 'Move the selected instance variable to the class side of its own class'
]

{ #category : 'accessing' }
StMoveInstanceVariableToClassSideCommand class >> defaultIconName [
	^ #smallRedo
]

{ #category : 'default' }
StMoveInstanceVariableToClassSideCommand class >> defaultName [

	^ '(T) Move to class side'
]

{ #category : 'testing' }
StMoveInstanceVariableToClassSideCommand >> canBeExecuted [

	^ self codePresenter selectedNode isInstanceVariable and: [ self codePresenter selectedNode isGlobalVariable not ]
]

{ #category : 'executing' }
StMoveInstanceVariableToClassSideCommand >> prepareDriver [

	^ (ReMoveVariablesToClassSideDriver newApplication: self application)
		  scopes: context allScopes
		  variables: { self codePresenter selectedNode variable }
]
