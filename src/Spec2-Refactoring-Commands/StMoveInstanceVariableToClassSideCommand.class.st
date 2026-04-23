"
I am a command to move given instance variable to its class side
"
Class {
	#name : 'StMoveInstanceVariableToClassSideCommand',
	#superclass : 'StRefactoringVariableCommand',
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

{ #category : 'executing' }
StMoveInstanceVariableToClassSideCommand >> prepareDriver [

	^ (ReMoveVariablesToClassSideDriver newApplication: self application)
		  scopes: context allScopes
		  variables: { self codePresenter selectedNode variable }
]
