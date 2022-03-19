"
Demo page for SpecDemoRadioButtonsPresenter.
"
Class {
	#name : #SpDemoRadioButtonsPage,
	#superclass : #SpDemoPage,
	#category : #'Spec2-Examples-Demo-Buttons'
}

{ #category : #initialization }
SpDemoRadioButtonsPage class >> pageName [
	^ 'Radio buttons'
]

{ #category : #initialization }
SpDemoRadioButtonsPage class >> priority [

	^ 900
]

{ #category : #initialization }
SpDemoRadioButtonsPage >> pageClass [
	^ SpDemoRadioButtonsPresenter
]
