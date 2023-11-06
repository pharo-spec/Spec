"
I define a popover needs to be shown at the top of its owner.
"
Class {
	#name : 'SpPopoverTopPosition',
	#superclass : 'SpPopoverPosition',
	#category : 'Spec2-Core-Support',
	#package : 'Spec2-Core',
	#tag : 'Support'
}

{ #category : 'operations' }
SpPopoverTopPosition >> applyTo: aWidget [

	aWidget bePositionTop
]
