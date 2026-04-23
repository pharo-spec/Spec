"
I am a command to push down given variables
"
Class {
	#name : 'StPushDownVariableCommand',
	#superclass : 'StRefactoringVariableCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'default' }
StPushDownVariableCommand class >> defaultDescription [

	^ 'Push down the selected instance variable'
]

{ #category : 'accessing' }
StPushDownVariableCommand class >> defaultIconName [

	^ #down
]

{ #category : 'default' }
StPushDownVariableCommand class >> defaultName [

	^ '(R) Push down'
]

{ #category : 'executing' }
StPushDownVariableCommand >> prepareDriver [

	^ (RePushDownInstanceVariableDriver newApplication: self application)
		  scopes: context allScopes;
		  variables: {self codePresenter selectedNode variable}
]
