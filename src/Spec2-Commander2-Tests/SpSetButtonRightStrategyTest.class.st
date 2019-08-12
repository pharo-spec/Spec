"
A SpSetButtonRightStrategyTest is a test class for testing the behavior of SpSetButtonRightStrategy
"
Class {
	#name : #SpSetButtonRightStrategyTest,
	#superclass : #TestCase,
	#category : #'Spec2-Commander2-Tests'
}

{ #category : #test }
SpSetButtonRightStrategyTest >> testAddTo [
	| actionBar button |
	actionBar := SpActionBarPresenter new.
	button := ButtonPresenter new.
	
	self assert: actionBar items isEmpty.
	
	SpSetButtonRightStrategy new
		add: button to: actionBar.
		
	self assert: actionBar items size equals: 1.
	self assert: (actionBar items includesKey: #end).
	self assert: (actionBar items at: #end) size equals: 1.
	self assert: (actionBar items at: #end) anyOne equals: button
]
