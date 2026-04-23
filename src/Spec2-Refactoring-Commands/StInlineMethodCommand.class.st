"
I am a command to inline ""self send"" method directly into sender method
"
Class {
	#name : 'StInlineMethodCommand',
	#superclass : 'StRefactoringCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'default' }
StInlineMethodCommand class >> defaultDescription [

	^ 'Inline "self send" method directly into sender method'
]

{ #category : 'accessing' }
StInlineMethodCommand class >> defaultIconName [
	^ #smallRightFlush
]

{ #category : 'default' }
StInlineMethodCommand class >> defaultName [

	^ 'Inline method'
]

{ #category : 'testing' }
StInlineMethodCommand >> canBeExecuted [

	^ self codePresenter selectedNode isMessage
]

{ #category : 'executing' }
StInlineMethodCommand >> prepareDriver [

	^ (ReInlineMethodDriver newApplication: self application)
		  scopes: context allScopes
		  interval: self codePresenter selectedNode sourceInterval
		  selector: context selectedMethod selector
		  class: context selectedMethod origin
]
