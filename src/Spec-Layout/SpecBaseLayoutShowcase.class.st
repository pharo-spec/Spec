Class {
	#name : #SpecBaseLayoutShowcase,
	#superclass : #ComposablePresenter,
	#instVars : [
		'displayedLayout',
		'control'
	],
	#category : #'Spec-Layout-Examples'
}

{ #category : #accessing }
SpecBaseLayoutShowcase class >> label [ 

	^ self subclassResponsibility
]
