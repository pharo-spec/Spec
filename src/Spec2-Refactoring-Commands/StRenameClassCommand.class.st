"
Rename selected class from a code presenter
"
Class {
	#name : 'StRenameClassCommand',
	#superclass : 'StRefactoringCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'default' }
StRenameClassCommand class >> defaultDescription [

	^ 'Rename selected class'
]

{ #category : 'accessing' }
StRenameClassCommand class >> defaultIconName [

	^ #edit 
]

{ #category : 'default' }
StRenameClassCommand class >> defaultName [

	^ '(R) Rename'
]

{ #category : 'testing' }
StRenameClassCommand >> canBeExecuted [

	| node |
	node := self codePresenter selectedNode.
	^ node isGlobalVariable and: [ node binding value isClass ]
]

{ #category : 'executing' }
StRenameClassCommand >> prepareDriver [

	^ (ReRenameClassDriver rename: self codePresenter selectedNode name)
		  model: RBBrowserEnvironment new;
		  scopes: context allScopes
]
