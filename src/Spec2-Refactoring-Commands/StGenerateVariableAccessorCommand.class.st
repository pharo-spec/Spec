"
I am a command to generate accessors for given variables
"
Class {
	#name : 'StGenerateVariableAccessorCommand',
	#superclass : 'StRefactoringCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'default' }
StGenerateVariableAccessorCommand class >> defaultDescription [

	^ 'Generate accessor for the selected instance variable'
]

{ #category : 'default' }
StGenerateVariableAccessorCommand class >> defaultIconName [

	^ #smallAdd
]

{ #category : 'default' }
StGenerateVariableAccessorCommand class >> defaultName [

	^ '(T) Generate accessor'
]

{ #category : 'testing' }
StGenerateVariableAccessorCommand >> canBeExecuted [

	^ self codePresenter selectedNode isInstanceVariable and: [ self codePresenter selectedNode isGlobalVariable not ]
]

{ #category : 'executing' }
StGenerateVariableAccessorCommand >> prepareDriver [

	^ (ReGenerateAccessorsDriver newApplication: self application)
		  targetClass: context selectedMethod origin;
		  scopes: context allScopes
		  scopeInstanceSide: context selectedMethod origin isInstanceSide
		  selectedVariables: { self codePresenter selectedNode name }
]
