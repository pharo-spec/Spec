"
Extract selected interval into a temporary variable from a code presenter 
"
Class {
	#name : 'StExtractTempCommand',
	#superclass : 'StRefactoringCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

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
StExtractTempCommand >> execute [

	(ReExtractTempDriver new
		 extract: self codePresenter selectedNode sourceInterval
		 from: context selectedMethod selector
		 in: context selectedMethod origin;
		 scopes: context allScopes) runRefactoring
]
