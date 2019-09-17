Class {
	#name : #SpDemoMenuButtonPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'actionBar',
		'text',
		'menu',
		'button'
	],
	#category : #'Spec2-Examples-Demo-Buttons'
}

{ #category : #specs }
SpDemoMenuButtonPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical 
		add: (SpBoxLayout newHorizontal
			add: #button;
			add: #menu expand: false fill: false padding: 0;
			yourself) 
			expand: false 
			fill: false 
			padding: 0;
		add: #text;
		yourself
]

{ #category : #initialization }
SpDemoMenuButtonPresenter >> initializePresenters [
	<script: 'self new openWithSpec'>

	(button := self newButton)
		label: 'Choice';
		action: [ text text: text text, button label, String cr ].
			
	menu := self newMenuButton
		help: 'An example menu.';
		menu: self newExampleMenu;
		yourself.


	text := self newText
]

{ #category : #initialization }
SpDemoMenuButtonPresenter >> newExampleMenu [
	
	^ SpMenuPresenter new
		addGroup: [ :group | group
			addItem: [ :item | item name: 'One'; action: [ button label: 'One' ] ];
			addItem: [ :item | item name: 'Two'; action: [ button label: 'Two' ]  ];
			addItem: [ :item | item name: 'Three'; action: [ button label: 'Three' ]  ] ];
		yourself
]
