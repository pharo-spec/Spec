"
I am an example presenter to show how commands can be used as the basis for adding a menubar and a toolbar.
"
Class {
	#name : 'SpCommandGroupExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'menuBar',
		'toolBar',
		'list'
	],
	#category : 'Spec2-Examples-Demo-CommandGroup',
	#package : 'Spec2-Examples',
	#tag : 'Demo-CommandGroup'
}

{ #category : 'commands' }
SpCommandGroupExample class >> buildCommandsGroupWith: presenter forRoot: rootCommandGroup [

	rootCommandGroup
		register: (self buildMenuBarGroupWith: presenter);
		register: (self buildToolBarGroupWith: presenter)
]

{ #category : 'commands' }
SpCommandGroupExample class >> buildMenuBarGroupWith: presenter [

	^ (CmCommandGroup named: 'MenuBar') asSpecGroup
		beRoot;
		register: (self buildMenuWith: presenter);
		yourself
]

{ #category : 'commands' }
SpCommandGroupExample class >> buildMenuWith: presenter [

	^ (CmCommandGroup named: 'Menu') asSpecGroup
		register: (SpExampleNewCommand forSpec context: presenter);
		yourself
]

{ #category : 'commands' }
SpCommandGroupExample class >> buildToolBarGroupWith: presenter [

	^ (CmCommandGroup named: 'ToolBar') asSpecGroup
		beRoot;
		register: (SpExampleNewCommand forSpec context: presenter);
		yourself
]

{ #category : 'examples' }
SpCommandGroupExample class >> example [
	"This example opens a presenter with a menubar and a toolbar created from commands."

	^ self new open
]

{ #category : 'layout' }
SpCommandGroupExample >> defaultLayout [

	^ SpBoxLayout newTopToBottom
]

{ #category : 'initialization' }
SpCommandGroupExample >> initializeMenuBar [

	menuBar := (self rootCommandsGroup / 'MenuBar') asMenuBarPresenter
]

{ #category : 'initialization' }
SpCommandGroupExample >> initializePresenters [

	super initializePresenters.
	self initializeMenuBar.
	self initializeToolBar
]

{ #category : 'initialization' }
SpCommandGroupExample >> initializeToolBar [

	toolBar := self newToolbar.
	toolBar fillWith: self rootCommandsGroup / 'ToolBar'
]

{ #category : 'initialization' }
SpCommandGroupExample >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		title: 'Example with menubar and toolbar based on commands';
		initialExtent: 500@200;
		menu: menuBar;
		toolbar: toolBar
]
