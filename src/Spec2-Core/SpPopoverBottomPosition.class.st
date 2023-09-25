"
I define a popover needs to be shown at the bottom of its owner.
"
Class {
	#name : 'SpPopoverBottomPosition',
	#superclass : 'SpPopoverPosition',
	#category : 'Spec2-Core-Support',
	#package : 'Spec2-Core',
	#tag : 'Support'
}

{ #category : 'operations' }
SpPopoverBottomPosition >> applyTo: aWidget [

	aWidget bePositionBottom
]
