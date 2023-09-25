"
I define a popover needs to be shown at the right of its owner.
"
Class {
	#name : 'SpPopoverRightPosition',
	#superclass : 'SpPopoverPosition',
	#category : 'Spec2-Core-Support',
	#package : 'Spec2-Core',
	#tag : 'Support'
}

{ #category : 'operations' }
SpPopoverRightPosition >> applyTo: aWidget [

	aWidget bePositionRight
]
