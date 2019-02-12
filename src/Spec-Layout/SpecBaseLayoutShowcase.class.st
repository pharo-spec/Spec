Class {
	#name : #SpecBaseLayoutShowcase,
	#superclass : #ComposablePresenter,
	#instVars : [
		'displayedLayout',
		'control',
		'currentLayoutSpec'
	],
	#category : #'Spec-Layout-Examples'
}

{ #category : #accessing }
SpecBaseLayoutShowcase class >> label [ 

	^ self subclassResponsibility
]

{ #category : #initialization }
SpecBaseLayoutShowcase >> currentLayoutSpec [

	^ currentLayoutSpec
]

{ #category : #initialization }
SpecBaseLayoutShowcase >> newLayout [

	^ SpecLayoutShowcaseInstance new
		owner: self;
		layout: self currentLayoutSpec;
		yourself
]
