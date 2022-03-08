"
A demo to show how to use associated toggle buttons with Spec.

self example
"
Class {
	#name : #SpToggleButtonExample,
	#superclass : #SpPresenter,
	#instVars : [
		'button1',
		'button2',
		'button3',
		'label'
	],
	#category : #'Spec2-Examples-Demo-Buttons'
}

{ #category : #examples }
SpToggleButtonExample class >> example [

	^ self new open
]

{ #category : #specs }
SpToggleButtonExample class >> title [

	^ 'Toggle Button Example'
]

{ #category : #initialization }
SpToggleButtonExample >> connectPresenters [

	button1 whenActivatedDo: [ self updateLabel ].
	button1 whenDeactivatedDo: [ self updateLabel ].
	button2 whenChangedDo: [ self updateLabel ].
	button3 whenChangedDo: [ self updateLabel ]
]

{ #category : #layout }
SpToggleButtonExample >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newTopToBottom
				   add: button1 expand: false;
				   add: button2 expand: false;
				   add: button3 expand: false;
				   yourself);
		  add: label expand: false;
		  yourself
]

{ #category : #initialization }
SpToggleButtonExample >> initializePresenters [

	button1 := self newToggleButton.
	button2 := self newToggleButton.
	button3 := self newToggleButton.
	label := self newLabel.
	button1 associatedToggleButtons: { button2. button3 }.

	button1 label: 'Button 1'.
	button2 label: 'Button 2'.
	button3 label: 'Button 3'.

	self updateLabel
]

{ #category : #updating }
SpToggleButtonExample >> updateLabel [
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
