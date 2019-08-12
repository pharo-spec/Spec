"
I set the button generated from a command on the right side of the action bar.
"
Class {
	#name : #SpSetButtonRightStrategy,
	#superclass : #SpActionBarPresenterStrategy,
	#category : #'Spec2-Commander2-Core'
}

{ #category : #adding }
SpSetButtonRightStrategy >> add: aButtonPresenter to: anActionBarPresenter [
	anActionBarPresenter addLast: aButtonPresenter
]
