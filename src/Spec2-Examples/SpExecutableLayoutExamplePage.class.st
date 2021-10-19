"
In the current spec status (19/10/2021), I am a documented example of how to use SpScrollableLayouts.
"
Class {
	#name : #SpExecutableLayoutExamplePage,
	#superclass : #SpPresenter,
	#category : #'Spec2-Examples-Layouts'
}

{ #category : #building }
SpExecutableLayoutExamplePage >> addTextFieldTo: aLayout [

	aLayout
		add: (self newLabel
				 label: 'This is a text field';
				 yourself)
		expand: false
		fill: false
		padding: 5.
	aLayout add: self newText withConstraints: [ :c | c height: 120 ]
]

{ #category : #initialization }
SpExecutableLayoutExamplePage >> initializePresenters [
	<script: 'self new openWithSpec'>
	|scrollablePresenter|
	super initializePresenters.
	
	"We initialize the layout to a vertical box layout.
	Presenters will stack vertically."
	layout := SpBoxLayout newTopToBottom.
	
	"For this demo, we add a lot of presenters (here, text fields.
	The idea is to fill the entire vertical space so that we need 
	to scroll up and down to see all the presenters."
	10 timesRepeat: [ self addTextFieldTo: layout ].		

	self flag: 'The following is how SpScrollablePresenter work today. 
	It should change in the future to directly take our box layout as input instead of the following.'.
	"To use a scroll layout, we need to embed our own layout into an intermediate presenter."
	scrollablePresenter := SpPresenter new.
	scrollablePresenter layout: layout.
	
	"We then set our layout to a scrollable layout in which we
	have a single presenter (our intermediate presenter)"
	self layout: (SpScrollableLayout with: scrollablePresenter)
]
