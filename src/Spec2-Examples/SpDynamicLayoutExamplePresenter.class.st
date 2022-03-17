"
I am a dynamic layout example
"
Class {
	#name : #SpDynamicLayoutExamplePresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'addPresenterButton',
		'removePreseterButton',
		'textPresenter',
		'canRemovePresenter'
	],
	#category : #'Spec2-Examples-Demo-Layouts'
}

{ #category : #actions }
SpDynamicLayoutExamplePresenter >> addToLayout [

	canRemovePresenter := true.
	removePreseterButton enable.
	
	self layout add: self createButton expand: false
]

{ #category : #actions }
SpDynamicLayoutExamplePresenter >> createButton [

	| randomButtonName newButton |
	randomButtonName := 'Random number: ', (Random new nextBetween: 100 and: 1000) asInteger asString.

	newButton := self newButton.
	newButton
		label: randomButtonName;
		icon: (self iconNamed: #smallObjects).
	^ newButton
]

{ #category : #layout }
SpDynamicLayoutExamplePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: addPresenterButton expand: false;
		add: removePreseterButton expand: false;
		add: textPresenter;
		yourself		
]

{ #category : #initialization }
SpDynamicLayoutExamplePresenter >> initialize [

	super initialize.
	canRemovePresenter := false
]

{ #category : #initialization }
SpDynamicLayoutExamplePresenter >> initializePresenters [

	addPresenterButton := self newButton.
	addPresenterButton
		action: [ self addToLayout ];
		label: 'Add a presenter to the layout';
		icon: (self iconNamed: #smallAdd).
		
	removePreseterButton := self newButton.
	removePreseterButton
		action: [ self removeFromLayout ];
		label: 'Remove a presenter from the layout';
		icon: (self iconNamed: #smallDelete);
		disable.
		
	textPresenter := self newText.
	textPresenter
		text: 'I am a text presenter.
		I will not be removed';
		beNotEditable
]

{ #category : #actions }
SpDynamicLayoutExamplePresenter >> removeFromLayout [

	self layout remove: self layout presenters last.

	self layout presenters last = textPresenter
		ifTrue: [ removePreseterButton disable ]
]
