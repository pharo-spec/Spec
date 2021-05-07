"
I define a popover needs to be shown at the left of its owner.
"
Class {
	#name : #SpPopoverLeftPosition,
	#superclass : #SpPopoverPosition,
	#category : #'Spec2-Core-Support'
}

{ #category : #operations }
SpPopoverLeftPosition >> applyTo: aWidget [

	aWidget bePositionLeft
]
