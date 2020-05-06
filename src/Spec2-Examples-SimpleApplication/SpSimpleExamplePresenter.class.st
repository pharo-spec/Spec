"
! A (simple) sample presenter

A simple presenter to show how I can construct and show a window in the context of a Spec application. 
It will show a simple title, a message and a button.

"
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
	"A defaultSpec (@TODO change name for defaultLayout) will define the layout to arrange the
	 different elements of this presenter. See *SpExecutableLayout*.
	[[[language=Smalltalk
	^ SpBoxLayout newVertical
		add: #titleLabel;
		add: #messageLabel expand: false;
		add: (SpBoxLayout newHorizontal
				hAlignCenter;
				add: #actionButton;
				yourself)
			expand: false;
		yourself	
	]]]"

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
	"Initialize presenters: you will add your presenters here.
	 BEWARE! all your presenters names need to match the name defined in the *SpSimpleExamplePresenter class>>defaultSpec* method.

	[[[language=Smalltalk
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
	]]]	" 

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
	"A presenter can be composed as part of another presenter. 
	 But it can also be shown as a window. 
	 Define here the window properties you need (see *SpWindowPresenter*)
	
	[[[language=Smalltalk
	aWindowPresenter 
		title: 'Simple Application';
		initialExtent: 400@400
	]]]
	"

	aWindowPresenter 
		title: 'Simple Application';
		initialExtent: 400@400
]
