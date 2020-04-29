Class {
	#name : #SpSimpleExamplePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'titleLabel',
		'messageLabel',
		'actionButton'
	],
	#category : #'Spec2-Examples-SimpleApplication'
}

{ #category : #specs }
SpSimpleExamplePresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #titleLabel;
		add: #messageLabel expand: false;
		add: (SpBoxLayout newHorizontal
				hAlignCenter;
				add: #actionButton;
				yourself)
			expand: false;
		yourself
]

{ #category : #initialization }
SpSimpleExamplePresenter >> initializePresenters [

	titleLabel := self newLabel
		label: 'A Simple Title';
		addStyle: 'title';
		yourself.
	messageLabel := self newLabel
		label: 'Some message';
		yourself.

	actionButton := self newButton 
		label: 'A button';
		action: [  ];
		yourself
]

{ #category : #initialization }
SpSimpleExamplePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: 'Simple Application';
		initialExtent: 400@400
]
