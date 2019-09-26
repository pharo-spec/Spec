Class {
	#name : #SpMockFocusOrderPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'firstPresenter',
		'secondPresenter',
		'thirdPresenter'
	],
	#category : #'Spec2-Backend-Tests'
}

{ #category : #specs }
SpMockFocusOrderPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #firstPresenter;
		add: #secondPresenter;
		add: #thirdPresenter;
		yourself
]

{ #category : #initialization }
SpMockFocusOrderPresenter >> initializePresenters [

	firstPresenter := self newTextInput.
	secondPresenter := self newTextInput.
	thirdPresenter := self newTextInput
]
