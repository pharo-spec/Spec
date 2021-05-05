"
I am an elementary Spec widget allowing a user to choose a Color by its RGB values.

self example

I manage three SliderInput.
I set their min at 0 and their max at 255.

I provide the methods color that calculate the Color obtains with the current value of the sliders.
"
Class {
	#name : #SpRGBSliders,
	#superclass : #SpRGBSlidersPresenter,
	#category : #'Spec2-Morphic-Widgets'
}

{ #category : #testing }
SpRGBSliders class >> isDeprecated [ 
	^ true
]
