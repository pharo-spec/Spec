"
I'm a base command for refactorings. 
My children will define commands for refactoring support in spec
"
Class {
	#name : 'StRefactoringCommand',
	#superclass : 'StCommand',
	#category : 'Spec2-Refactoring-Commands',
	#package : 'Spec2-Refactoring-Commands'
}

{ #category : 'accessing' }
StRefactoringCommand >> codePresenter [

	^ context codePresenter
]
