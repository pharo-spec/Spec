"
I set the button generated from a command on the left side a presenter.
"
Class {
	#name : #SpRightPositionStrategy,
	#superclass : #SpPositionStrategy,
	#category : #'Spec2-Commander2-Core'
}

{ #category : #adding }
SpRightPositionStrategy >> addButton: aButtonPresenter toActionBar: anActionBarPresenter [
	anActionBarPresenter addLast: aButtonPresenter
]
