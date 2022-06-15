"
This demo shows differenty styles of button elements.
"
Class {
	#name : #SpDemoButtonsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'buttonNormal',
		'buttonDisabled',
		'buttonWithIcon',
		'buttonWithIconOnly',
		'buttonHighlighted',
		'buttonWithColor',
		'buttonWithMenu',
		'buttonWithShortcut',
		'buttonWithHelp',
		'buttonWithDifferentFont'
	],
	#category : #'Spec2-Examples-Demo-Buttons'
}

{ #category : #initialization }
SpDemoButtonsPresenter >> connectPresenters [

	buttonWithShortcut action: [ self inform: 'button with shortcut pressed' ]																																														
]

{ #category : #layout }
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
			add: buttonWithShortcut;
			add: buttonWithHelp;
			nextRow;
			add: buttonWithDifferentFont ]
]

{ #category : #initialization }
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
		contextMenu: self subMenu;
		yourself.
	buttonWithShortcut := self newButton
		shortcut: $o meta;
		label: 'with shortcut';
		yourself.
	buttonWithHelp := self newButton
		label: 'with help';
		help:
			'This button shows
a multiline help';
		yourself.
	buttonWithDifferentFont := self newButton
		label: 'different font';
		font: StandardFonts codeFont;
		yourself.
	
	self focusOrder
		add: buttonNormal;
		add: buttonDisabled;
		add: buttonWithIcon;
		add: buttonWithIconOnly;
		add: buttonHighlighted;
		add: buttonWithColor;
		add: buttonWithMenu;
		add: buttonWithShortcut;
		add: buttonWithHelp;
		add: buttonWithDifferentFont
]

{ #category : #initialization }
SpDemoButtonsPresenter >> subMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Open';
				icon: (self iconNamed: #openIcon);
				shortcut: $o meta;
				action: [ self inform: 'Open' ] ];
		addItem: [ :item | 
			item
				name: 'Save';
				icon: (self iconNamed: #smallSave);
				shortcut: $s meta;
				action: [ self inform: 'Save' ] ];
		addItem: [ :item | 
			item
				name: 'Print';
				shortcut: $p meta;
				icon: (self iconNamed: #smallPrintIcon);
				action: [ self inform: 'Print' ] ];
		addItem: [ :item | 
			item
				name: 'Kill';
				shortcut: $k meta;
				icon: (self iconNamed: #smallCancel);
				action: [ self inform: 'Kill' ] ];
		yourself
]
