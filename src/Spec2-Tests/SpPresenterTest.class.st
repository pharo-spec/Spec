Class {
	#name : #SpPresenterTest,
	#superclass : #TestCase,
	#category : #'Spec2-Tests-Core'
}

{ #category : #tests }
SpPresenterTest >> testPresentersIncludesPresentersAddedToTheLayout [
	| presenter p1 p2 |
	
	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newTopToBottom
		add: (p1 := presenter newLabel);
		add: (p2 := presenter newLabel);
		yourself).
	
	self assert: presenter presenters equals: { p1. p2 }
]

{ #category : #tests }
SpPresenterTest >> testTraversePresentersDoIncludesPresentersAddedToTheLayout [
	| presenter p1 p2 result |
	
	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newTopToBottom
		add: (p1 := presenter newLabel);
		add: (p2 := presenter newLabel);
		yourself).
	
	result := Array streamContents: [ :stream | 
		presenter traversePresentersDo: [ :each | stream << each ] ].	
	self assert: result equals: { presenter. p1. p2 }
]
