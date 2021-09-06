"
Description
--------------------

I am a state of a ProgressBarPresenter managing the behavior of a indeterminated progress bar. I will have no value and display a bar going back and forth.

Examples
--------------------

	ProgressBarIndeterminated new
"
Class {
	#name : #SpIndeterminatedProgressBarState,
	#superclass : #SpProgressBarState,
	#category : #'Spec2-Core-Utils'
}

{ #category : #'api-events' }
SpIndeterminatedProgressBarState >> whenValueChangedDo: aBlock [
	"Value cannot change in indeterminate state"
]
