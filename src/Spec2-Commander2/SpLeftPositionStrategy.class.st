"
I set the button generated from a command on the left side a presenter.
"
Class {
	#name : #SpLeftPositionStrategy,
	#superclass : #SpPositionStrategy,
	#category : #'Spec2-Commander2-Core'
}

{ #category : #adding }
SpLeftPositionStrategy >> addButton: aButtonPresenter toActionBar: anActionBarPresenter [
	anActionBarPresenter add: aButtonPresenter
]
