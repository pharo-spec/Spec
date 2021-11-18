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
	presenter layout: (SpBoxLayout new add:  SpListPresenter  new; add: SpTextPresenter new; yourself).
	
	3 timesRepeat: [ 
		presenter openWithSpec.
		presenter window close ].
	
	self assert: presenter dependents size equals: 1.

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

{ #category : #tests }
SpPresenterTest >> testUnsubscribeLayoutTraversesAllLayout [
	"This is a hacky way to test that changing layouts execute the right amount 
	 of times the unsubscribe method"
	
	"This test includes a dependency with reflectivity package and it does not worths 
	 for what is bringing us So I am disabling it (but letting it commented to not lose 
	 the code, even if I am going to forget it exists ;)"
	
	"| label button method counter |
	
	presenter := SpPresenter new.
	label := presenter newLabel.
	button := presenter newButton.
	presenter layout: (SpBoxLayout newVertical
		borderWidth: 10;
		add: label;
		add: (SpBoxLayout newHorizontal 
			add: (SpBoxLayout newVertical 
				add: button;
				yourself);
			yourself);
		yourself).
	[
		method := SpAbstractPresenter>>#unsubscribe:.
		counter := ExecutionCounter installOn: method ast.
		presenter openWithSpec.
		presenter layout: (SpBoxLayout newHorizontal
			borderWidth: 10;
			add: label;
			add: (SpBoxLayout newHorizontal 
				add: (SpBoxLayout newVertical 
					add: button;
					yourself);
				yourself);
			yourself).
		self assert: counter count equals: 3 ]
	ensure: [ 
		ExecutionCounter removeAll.
		method recompile.
		presenter withWindowDo: #close ]"
]
