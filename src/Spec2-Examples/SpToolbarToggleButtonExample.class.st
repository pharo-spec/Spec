"
A demo to show how to use associated toolbar toggle buttons with Spec.

self example
"
Class {
	#name : #SpToolbarToggleButtonExample,
	#superclass : #SpPresenter,
	#instVars : [
		'button1',
		'button2',
		'button3',
		'label',
		'toolbar'
	],
	#category : #'Spec2-Examples-Demo-Checkboxes'
}

{ #category : #specs }
SpToolbarToggleButtonExample class >> defaultSpec [
	^ SpBoxLayout newTopToBottom
		add: (SpBoxLayout newTopToBottom
			vAlignStart;
			add: #toolbar expand: false;
			yourself);
		add: #label expand: false;
		yourself
]

{ #category : #examples }
SpToolbarToggleButtonExample class >> example [

	^ self new openWithSpec
]

{ #category : #specs }
SpToolbarToggleButtonExample class >> title [

	^ 'Radio Button Example'
]

{ #category : #initialization }
SpToolbarToggleButtonExample >> connectPresenters [

	button1 whenActivatedDo: [ self updateLabel ].
	button1 whenDeactivatedDo: [ self updateLabel ].
	button2 whenChangedDo: [ self updateLabel ].
	button3 whenChangedDo: [ self updateLabel ]
]

{ #category : #initialization }
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

	button1 label: 'Button 1'.
	button2 label: 'Button 2'.
	button3 label: 'Button 3'.

	self updateLabel
]

{ #category : #updating }
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
