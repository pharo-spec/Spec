"
I am an elementary Spec Widget managing a slider and an input.

Self example

Between the bounds min and max of the slider, I ensure that the value of the input on the accept and the value of the slider are the same.

Note
====
- min and max must be set before use me.
- if autoAccept is true, the character '-' could create problems
"
Class {
	#name : #SpSliderInput,
	#superclass : #SpSliderInputPresenter,
	#category : #'Spec2-Core-Widgets'
}

{ #category : #testing }
SpSliderInput class >> isDeprecated [ 
	^ true
]
