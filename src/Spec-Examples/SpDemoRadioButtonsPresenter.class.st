"
This demo shows differenty styles of radio buttons.
"
Class {
	#name : #SpDemoRadioButtonsPresenter,
	#superclass : #SpComposablePresenter,
	#instVars : [
		'radioButtonExample'
	],
	#category : #'Spec-Examples-Demo-Checkboxes'
}

{ #category : #specs }
SpDemoRadioButtonsPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #radioButtonExample;
		yourself
]

{ #category : #initialization }
SpDemoRadioButtonsPresenter >> initializeWidgets [
	radioButtonExample := self instantiate: SpRadioButtonExample
]
