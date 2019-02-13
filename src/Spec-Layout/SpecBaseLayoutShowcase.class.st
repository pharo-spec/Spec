Class {
	#name : #SpecBaseLayoutShowcase,
	#superclass : #ComposablePresenter,
	#instVars : [
		'displayedLayout',
		'control',
		'layoutSpec'
	],
	#category : #'Spec-Layout-Examples'
}

{ #category : #accessing }
SpecBaseLayoutShowcase class >> label [ 

	^ self subclassResponsibility
]

{ #category : #initialization }
SpecBaseLayoutShowcase >> initialize [ 
	
	self initializeLayout.		
	super initialize.
]

{ #category : #initialization }
SpecBaseLayoutShowcase >> initializeLayout [
]

{ #category : #private }
SpecBaseLayoutShowcase >> layoutSpec [

	^ layoutSpec
]

{ #category : #private }
SpecBaseLayoutShowcase >> newLayout [

	^ SpecLayoutShowcaseInstance new
		owner: self;
		layout: self layoutSpec;
		yourself
]
