"
I am an example of a popover content.
I will show a simple text.
"
Class {
	#name : 'SpPopoverContentExample',
	#superclass : 'SpPopoverContentPresenter',
	#category : 'Spec2-Examples-Standalone',
	#package : 'Spec2-Examples',
	#tag : 'Standalone'
}

{ #category : 'initialization' }
SpPopoverContentExample >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		borderWidth: 10; 
		add: (self newLabel label: 'A cool popup!');
		yourself)
]
