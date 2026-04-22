"
I am a command to rename temp variable in given method.
 

"
Class {
	#name : 'StRenameArgOrTempCommand',
	#superclass : 'StRefactoringCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'accessing' }
StRenameArgOrTempCommand class >> defaultIconName [

	^ #edit
]

{ #category : 'default' }
StRenameArgOrTempCommand class >> defaultName [

	^ '(R) Rename temp'
]

{ #category : 'testing' }
StRenameArgOrTempCommand >> canBeExecuted [

	^ self codePresenter selectedNode isTempVariable or: [ self codePresenter selectedNode isArgumentVariable ]
]

{ #category : 'executing' }
StRenameArgOrTempCommand >> prepareDriver [

	^ ReRenameArgumentOrTemporaryDriver new
		  sourceNode: self codePresenter selectedNode;
		  method: context selectedMethod;
		  scopes: context allScopes;
		  yourself
]
