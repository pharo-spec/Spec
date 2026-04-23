"
Extract selected interval into a temporary variable from a code presenter 
"
Class {
	#name : 'StExtractTempCommand',
	#superclass : 'StRefactoringCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'default' }
StExtractTempCommand class >> defaultDescription [

	^ 'Extract the selected code into a new temporary variable'
]

{ #category : 'accessing' }
StExtractTempCommand class >> defaultIconName [

	^ #smallUpdate
]

{ #category : 'default' }
StExtractTempCommand class >> defaultName [

	^ 'Extract temp'
]

{ #category : 'testing' }
StExtractTempCommand >> canBeExecuted [

	^ self codePresenter selectionInterval isNotEmpty
]

{ #category : 'executing' }
StExtractTempCommand >> prepareDriver [

	^ (ReExtractTempDriver newApplication: self application)
		  extract: self codePresenter selectedNode sourceInterval
		  from: context selectedMethod selector
		  in: context selectedMethod origin;
		  scopes: context allScopes
]
