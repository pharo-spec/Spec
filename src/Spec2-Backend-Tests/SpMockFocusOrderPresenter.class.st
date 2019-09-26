Class {
	#name : #SpMockFocusOrderPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'firstPresenter',
		'secondPresenter'
	],
	#category : #'Spec2-Backend-Tests'
}

{ #category : #specs }
SpMockFocusOrderPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #firstPresenter;
		add: #secondPresenter;
		yourself
]

{ #category : #initialization }
SpMockFocusOrderPresenter >> initializePresenters [

	firstPresenter := self newTextInput.
	secondPresenter := self newTextInput
]
