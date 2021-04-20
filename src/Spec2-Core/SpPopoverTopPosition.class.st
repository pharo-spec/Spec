"
I define a popover needs to be shown at the top of its owner.
"
Class {
	#name : #SpPopoverTopPosition,
	#superclass : #SpPopoverPosition,
	#category : #'Spec2-Core-Support'
}

{ #category : #operations }
SpPopoverTopPosition >> applyTo: aWidget [

	aWidget bePositionTop
]
