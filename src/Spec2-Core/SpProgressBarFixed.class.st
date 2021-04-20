"
Description
--------------------

I am a state of a ProgressBarPresenter managing the behavior of a fixed progress bar. I will have one value (between 0 and 1) and the progress will not change.

Examples
--------------------

	 ProgressBarFixed value: 0.1
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	valueHolder:		<aValueHolder> 		Value holder keeping the value I should be fixed on.

"
Class {
	#name : #SpProgressBarFixed,
	#superclass : #SpFixedProgressBarState,
	#category : #'Spec2-Core-Utils'
}

{ #category : #testing }
SpProgressBarFixed class >> isDeprecated [ 
	^ true
]
