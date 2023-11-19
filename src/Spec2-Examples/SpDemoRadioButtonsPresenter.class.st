"
This demo shows differenty styles of radio buttons.
"
Class {
	#name : 'SpDemoRadioButtonsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'radioButtonExample'
	],
	#category : 'Spec2-Examples-Demo-Buttons',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Buttons'
}

{ #category : 'layout' }
SpDemoRadioButtonsPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  add: radioButtonExample;
		  yourself
]

{ #category : 'initialization' }
SpDemoRadioButtonsPresenter >> initializePresenters [
	radioButtonExample := self instantiate: SpRadioButtonExample
]
