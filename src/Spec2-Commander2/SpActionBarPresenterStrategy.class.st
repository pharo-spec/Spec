"
I model a strategy to add a command on an action bar presenter.
"
Class {
	#name : #SpActionBarPresenterStrategy,
	#superclass : #Object,
	#category : #'Spec2-Commander2-Core'
}

{ #category : #adding }
SpActionBarPresenterStrategy >> add: aButtonPresenter to: anActionBarPresenter [
	self subclassResponsibility
]
