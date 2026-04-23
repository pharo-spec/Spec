"
I am a command to push up given variables
"
Class {
	#name : 'StPushUpVariableCommand',
	#superclass : 'StRefactoringVariableCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'default' }
StPushUpVariableCommand class >> defaultDescription [

	^ 'Push up the selected instance variable'
]

{ #category : 'accessing' }
StPushUpVariableCommand class >> defaultIconName [

	^ #up
]

{ #category : 'default' }
StPushUpVariableCommand class >> defaultName [
	^'(R) Push up'
]

{ #category : 'executing' }
StPushUpVariableCommand >> prepareDriver [

	^ (RePushUpVariableDriver newApplication: self application)
		  scopes: context allScopes
		  variables: {self codePresenter selectedNode variable}
		  to: self codePresenter behavior superclass
]
