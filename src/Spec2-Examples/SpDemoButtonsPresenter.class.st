"
This demo shows differenty styles of button elements.
"
Class {
	#name : 'SpDemoButtonsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'buttonNormal',
		'buttonDisabled',
		'buttonWithIcon',
		'buttonWithIconOnly',
		'buttonHighlighted',
		'buttonWithColor',
		'buttonWithMenu',
		'buttonWithHelp',
		'buttonWithDifferentFont'
	],
	#category : 'Spec2-Examples-Demo-Buttons',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Buttons'
}

{ #category : 'initialization' }
SpDemoButtonsPresenter >> connectPresenters [

	"buttonWithShortcut action: [ self inform: 'button with shortcut pressed' ]"																																														
]

{ #category : 'layout' }
SpDemoButtonsPresenter >> defaultLayout [

	^ SpGridLayout build: [ :builder | 
		builder
			beColumnHomogeneous;
			beRowHomogeneous;
			borderWidth: 0;
			add: buttonNormal;
			add: buttonDisabled;
			add: buttonWithIcon;
			nextRow;
			add: buttonWithIconOnly;
			add: buttonHighlighted;
			add: buttonWithColor;
			nextRow;
			add: buttonWithMenu;
			"add: buttonWithShortcut;"
			add: buttonWithHelp;
			"nextRow;"
			add: buttonWithDifferentFont ]
]

{ #category : 'initialization' }
SpDemoButtonsPresenter >> initializePresenters [

	buttonNormal := self newButton label: 'normal'.
	buttonDisabled := self newButton
		label: 'disabled';
		disable;
		yourself.
	buttonWithIcon := self newButton
		label: 'with icon';
		icon: ((self iconNamed: #pharo) scaledToSize: 16 @ 16);
		yourself.
	buttonWithIconOnly := self newButton
		icon: ((self iconNamed: #pharo) scaledToSize: 16 @ 16);
		help: 'This button has only icon, no label';
		yourself.
	buttonHighlighted := self newButton
		label: 'highlighted';
		state: true;
		yourself.
	buttonWithColor := self newButton
		label: 'red';
		color: Color red;
		yourself.
	buttonWithMenu := self newButton
		label: 'with menu';
		actions: self subMenuActions;
		yourself.
	"buttonWithShortcut := self newButton
		shortcut: $k ctrl;
		label: 'with shortcut ', $k ctrl printString;
		yourself."
	buttonWithHelp := self newButton
		label: 'with help';
		help:
			'This button shows
a multiline help';
		yourself.
	buttonWithDifferentFont := self newButton
		label: 'different font';
		font: StandardFonts codeFont;
		yourself
]

{ #category : 'initialization' }
SpDemoButtonsPresenter >> subMenuActions [

	^ SpActionGroup new
		addActionWith: [ :item | item
			name: 'Open';
			iconName: #opens;
			shortcut: $o actionModifier;
			action: [ self inform: 'Open' ] ];
		addActionWith: [ :item | item
			name: 'Save';
			iconName: #smallSave;
			shortcut: $s actionModifier;
			action: [ self inform: 'Save' ] ];
		addActionWith: [ :item | item
			name: 'Print';
			shortcut: $p actionModifier;
			iconName: #smallPrint;
			action: [ self inform: 'Print' ] ];
		addActionWith: [ :item | item
			name: 'Kill';
			shortcut: $k actionModifier;
			iconName: #smallCancel;
			action: [ self inform: 'Kill' ] ];
		yourself
]
