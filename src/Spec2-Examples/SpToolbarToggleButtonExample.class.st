"
A demo to show how to use associated toolbar toggle buttons with Spec.

self example
"
Class {
	#name : 'SpToolbarToggleButtonExample',
	#superclass : 'SpPresenter',
	#instVars : [
		'button1',
		'button2',
		'button3',
		'label',
		'toolbar'
	],
	#category : 'Spec2-Examples-Demo-Buttons',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Buttons'
}

{ #category : 'examples' }
SpToolbarToggleButtonExample class >> example [

	^ self new open
]

{ #category : 'specs' }
SpToolbarToggleButtonExample class >> title [

	^ 'Toolbar Toggle Button Example'
]

{ #category : 'initialization' }
SpToolbarToggleButtonExample >> connectPresenters [

	button1 whenActivatedDo: [ self updateLabel ].
	button1 whenDeactivatedDo: [ self updateLabel ].
	button2 whenChangedDo: [ self updateLabel ].
	button3 whenChangedDo: [ self updateLabel ]
]

{ #category : 'layout' }
SpToolbarToggleButtonExample >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newTopToBottom
				   vAlignStart;
				   add: toolbar expand: false;
				   yourself);
		  add: label expand: false;
		  yourself
]

{ #category : 'initialization' }
SpToolbarToggleButtonExample >> initializePresenters [

	toolbar := self newToolbar.

	button1 := self newToolbarToggleButton.
	button2 := self newToolbarToggleButton.
	button3 := self newToolbarToggleButton.
	
	toolbar add: button1.
	toolbar add: button2.
	toolbar add: button3.

	label := self newLabel.
	button1 associatedToggleButtons: { button2. button3 }.

	button1 label: 'Button 1'; icon: (self application iconNamed: #smallOk).
	button2 label: 'Button 2'; icon: (self application iconNamed: #smallOk).
	button3 label: 'Button 3'; icon: (self application iconNamed: #smallOk).

	self updateLabel
]

{ #category : 'updating' }
SpToolbarToggleButtonExample >> updateLabel [
	label
		label:
			(String
				streamContents: [ :s | 
					{button1 . button2 . button3}
						do: [ :button | 
							s
								<< button label;
								<< ' : ';
								<< (button state ifTrue: [ 'V' ] ifFalse: [ 'X' ]) ]
						separatedBy: [ s << ' - ' ] ])
]
