"
A SpSetButtonLeftStrategyTest is a test class for testing the behavior of SpSetButtonLeftStrategy
"
Class {
	#name : #SpSetButtonLeftStrategyTest,
	#superclass : #TestCase,
	#category : #'Spec2-Commander2-Tests'
}

{ #category : #test }
SpSetButtonLeftStrategyTest >> testAddTo [
	| actionBar button |
	actionBar := SpActionBarPresenter new.
	button := ButtonPresenter new.
	
	self assert: actionBar items isEmpty.
	
	SpSetButtonLeftStrategy new
		add: button to: actionBar.
		
	self assert: actionBar items size equals: 1.
	self assert: (actionBar items includesKey: #start).
	self assert: (actionBar items at: #start) size equals: 1.
	self assert: (actionBar items at: #start) anyOne equals: button
]
