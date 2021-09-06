"
This class has a single instance representing a right item position.

Do not use the class directly, instead use:

	ITItemPosition right
"
Class {
	#name : #SpToolbarItemPositionRight,
	#superclass : #SpToolbarItemRightPosition,
	#category : #'Spec2-Core-Widgets'
}

{ #category : #testing }
SpToolbarItemPositionRight class >> isDeprecated [ 
	^ true
]
