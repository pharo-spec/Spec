Class {
	#name : #SpPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'Spec2-Tests-Core'
}

{ #category : #tests }
SpPresenterTest >> testAdapterDoesNotRemainsAsDependencyWhenReplacingIt [

	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout new
			 add: SpListPresenter new;
			 add: SpTextPresenter new;
			 yourself).

	3 timesRepeat: [ 
		presenter open.
		presenter window close ].

	self assert: presenter dependents size equals: 1
]

{ #category : #tests }
SpPresenterTest >> testAsDialogWindow [

	presenter := SpPresenter new.
	self 
		assert: presenter asDialogWindow class
		equals: presenter application defaultDialogWindowPresenterClass
]

{ #category : #tests }
SpPresenterTest >> testAsModalWindow [

	presenter := SpPresenter new.
	self 
		assert: presenter asModalWindow class
		equals: presenter application defaultModalWindowPresenterClass
]

{ #category : #tests }
SpPresenterTest >> testAsWindow [

	presenter := SpPresenter new.
	self 
		assert: presenter asWindow class
		equals: presenter application defaultWindowPresenterClass
]

{ #category : #'tests - layout' }
SpPresenterTest >> testLayoutIsClassDefaultSpecWhenNoDefaultLayoutDefined [
	| presenterClass |
	
	presenterClass := SpPresenter newAnonymousSubclass.
	presenterClass class compile: 'defaultSpec ^ SpBoxLayout newLeftToRight'.
	presenter := presenterClass new.
	
	self 
		assert: presenter layout class 
		equals: SpBoxLayout
]

{ #category : #'tests - layout' }
SpPresenterTest >> testLayoutIsDefaultLayoutWhenDefaultLayoutAndDefaultSpecDefined [
	| presenterClass |
	
	presenterClass := SpPresenter newAnonymousSubclass.
	presenterClass class compile: 'defaultSpec ^ SpBoxLayout newLeftToRight'.
	presenterClass compile: 'defaultLayout ^ SpGridLayout new'.
	presenter := presenterClass new.
	
	self 
		assert: presenter layout class 
		equals: SpGridLayout
]

{ #category : #'tests - layout' }
SpPresenterTest >> testLayoutIsNotSetWhenAlreadyInitialized [
	| presenterClass |
	
	presenterClass := SpPresenter newAnonymousSubclass.
	presenterClass compile: 'defaultLayout ^ SpGridLayout new'.
	presenterClass compile: 'initializePresenters self layout: SpBoxLayout newLeftToRight'.
	presenter := presenterClass new.
	
	self 
		assert: presenter layout class 
		equals: SpBoxLayout
]

{ #category : #tests }
SpPresenterTest >> testPresentersIncludesPresentersAddedToTheLayout [
	| p1 p2 |
	
	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newTopToBottom
		add: (p1 := presenter newLabel);
		add: (p2 := presenter newLabel);
		yourself).
	
	self assert: presenter presenters equals: { p1. p2 }
]

{ #category : #tests }
SpPresenterTest >> testTraversePresentersDoIncludesPresentersAddedToTheLayout [
	| p1 p2 result |
	
	presenter := SpPresenter new.
	presenter layout: (SpBoxLayout newTopToBottom
		add: (p1 := presenter newLabel);
		add: (p2 := presenter newLabel);
		yourself).
	
	result := Array streamContents: [ :stream | 
		presenter traversePresentersDo: [ :each | stream << each ] ].	
	self assert: result equals: { presenter. p1. p2 }
]
