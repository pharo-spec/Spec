"
In the current spec status (08/03/2022), I am a documented example of how to use SpScrollableLayouts.
"
Class {
	#name : 'SpScrollableLayoutExamplePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'scrollablePresenter'
	],
	#category : 'Spec2-Examples-Demo-Layouts',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Layouts'
}

{ #category : 'building' }
SpScrollableLayoutExamplePresenter >> addTextFieldTo: aLayout [

	aLayout
		add: (self newLabel
				 label: 'This is a text field';
				 yourself)
		expand: false
		fill: false
		padding: 5.
	aLayout add: self newText withConstraints: [ :c | c height: 120 ]
]

{ #category : 'layout' }
SpScrollableLayoutExamplePresenter >> defaultLayout [

	^ SpScrollableLayout with: scrollablePresenter
]

{ #category : 'initialization' }
SpScrollableLayoutExamplePresenter >> initializePresenters [

	| largeLayout |
	super initializePresenters.
	
	"We initialize the layout to a vertical box layout.
	Presenters will stack vertically."
	largeLayout := SpBoxLayout newTopToBottom.
	
	"For this demo, we add a lot of presenters (here, text fields.
	The idea is to fill the entire vertical space so that we need 
	to scroll up and down to see all the presenters."
	10 timesRepeat: [ self addTextFieldTo: largeLayout ].		

	self flag: 'The following is how SpScrollablePresenter work today. 
	It should change in the future to directly take our box layout as input instead of the following.'.
	"To use a scroll layout, we need to embed our own layout into an intermediate presenter."
	scrollablePresenter := SpPresenter new.
	scrollablePresenter layout: largeLayout
]
