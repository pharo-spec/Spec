"
A simple example of a presenter that can be used as an Option in an Option List presenter.
"
Class {
	#name : #SpOptionPresenterExample,
	#superclass : #SpOptionPresenter,
	#instVars : [
		'radioPresenter'
	],
	#category : #'Spec2-Examples-Standalone'
}

{ #category : #examples }
SpOptionPresenterExample class >> open [
	<example>
	self new openWithSpec.
]

{ #category : #initialization }
SpOptionPresenterExample >> defaultLayout [ 
	^ SpBoxLayout newTopToBottom 
		add: radioPresenter;
		yourself.
]

{ #category : #initialization }
SpOptionPresenterExample >> initializePresenters [ 
	radioPresenter := self instantiate: SpDemoRadioButtonsPresenter.
	self layout: self defaultLayout.
]

{ #category : #initialization }
SpOptionPresenterExample >> optionIcon [

	^ self iconNamed: #radioButtonSelected
]

{ #category : #initialization }
SpOptionPresenterExample >> optionTitle [

	^ 'Radio Button Presenter'
]
