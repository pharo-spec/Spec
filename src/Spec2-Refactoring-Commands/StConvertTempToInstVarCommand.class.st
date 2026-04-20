"
I am a command to convert a temp variable in instance variable.
"
Class {
	#name : 'StConvertTempToInstVarCommand',
	#superclass : 'StRefactoringCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'accessing' }
StConvertTempToInstVarCommand class >> defaultIconName [

	^ #smallRedo
]

{ #category : 'default' }
StConvertTempToInstVarCommand class >> defaultName [

	^ '(R) Convert to Instance Var'
]

{ #category : 'testing' }
StConvertTempToInstVarCommand >> canBeExecuted [

	^ self codePresenter selectedNode isTempVariable
]

{ #category : 'executing' }
StConvertTempToInstVarCommand >> execute [ 

((ReConvertTemporaryToInstanceVariableDriver newApplication: self application)
		   scopes: context allScopes
		   class: context selectedMethod origin
		   selector: context selectedMethod selector
		   variable: self codePresenter selectedNode name) runRefactoring
]
