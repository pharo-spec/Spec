Class {
	#name : #SpSimpleExamplePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'titleLabel'
	],
	#category : #'Spec2-Examples-SimpleApplication'
}

{ #category : #specs }
SpSimpleExamplePresenter class >> defaultSpec [

	^ SpBoxLayout newVertical 
		add: #titleLabel;
		add: #messageLabel;
		add: (SpBoxLayout newHorizontal
			hAlignCenter;
			add: #button1;
			yourself)
]

{ #category : #initialization }
SpSimpleExamplePresenter >> initializePresenters [

	titleLabel := self newLabel
		addStyle: 'title';
		yourself.
		
	
]

{ #category : #initialization }
SpSimpleExamplePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Simple Application';
		initialExtent: 400@400
]
