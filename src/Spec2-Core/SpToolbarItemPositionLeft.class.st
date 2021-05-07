"
This class has a single instance representing a left item position.

Do not use the class directly, instead use:

	ITItemPosition left
"
Class {
	#name : #SpToolbarItemPositionLeft,
	#superclass : #SpToolbarItemLeftPosition,
	#category : #'Spec2-Core-Widgets'
}

{ #category : #testing }
SpToolbarItemPositionLeft class >> isDeprecated [ 
	^ true
]
