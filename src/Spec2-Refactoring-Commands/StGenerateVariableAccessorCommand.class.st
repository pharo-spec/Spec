"
I am a command to generate accessors for given variables
"
Class {
	#name : 'StGenerateVariableAccessorCommand',
	#superclass : 'StRefactoringVariableCommand',
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

{ #category : 'executing' }
StGenerateVariableAccessorCommand >> prepareDriver [

	^ (ReGenerateAccessorsDriver newApplication: self application)
		  targetClass: self codePresenter behavior;
		  scopes: context allScopes
		  scopeInstanceSide: self codePresenter behavior isInstanceSide
		  selectedVariables: { self codePresenter selectedNode name }
]
