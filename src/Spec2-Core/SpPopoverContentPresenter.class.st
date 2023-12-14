"
A popover content presenter. 
All popovers contents need to extent this presenter (to get some functionalies).
"
Class {
	#name : 'SpPopoverContentPresenter',
	#superclass : 'SpPresenter',
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'api' }
SpPopoverContentPresenter >> dismiss [

	^ self owner dismiss
]
