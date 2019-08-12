"
A SpSetButtonLeftStrategyTest is a test class for testing the behavior of SpSetButtonLeftStrategy
"
Class {
	#name : #SpLeftPositionStrategyTest,
	#superclass : #TestCase,
	#category : #'Spec2-Commander2-Tests'
}

{ #category : #test }
SpLeftPositionStrategyTest >> testAddButtonToActionBar [
	| actionBar button |
	actionBar := SpActionBarPresenter new.
	button := ButtonPresenter new.
	
	self assert: actionBar items isEmpty.
	
	SpLeftPositionStrategy new
		addButton: button toActionBar: actionBar.
		
	self assert: actionBar items size equals: 1.
	self assert: (actionBar items includesKey: #start).
	self assert: (actionBar items at: #start) size equals: 1.
	self assert: (actionBar items at: #start) anyOne equals: button
]
