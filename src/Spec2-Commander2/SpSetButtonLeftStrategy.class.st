"
I set the button generated from a command on the left side of the action bar.
"
Class {
	#name : #SpSetButtonLeftStrategy,
	#superclass : #SpActionBarPresenterStrategy,
	#category : #'Spec2-Commander2-Core'
}

{ #category : #adding }
SpSetButtonLeftStrategy >> add: aButtonPresenter to: anActionBarPresenter [
	anActionBarPresenter add: aButtonPresenter
]
