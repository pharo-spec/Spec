"
A SpSetButtonLeftStrategyTest is a test class for testing the behavior of SpSetButtonLeftStrategy
"
Class {
	#name : 'CmUILeftPositionStrategyExtensionsTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Commander2-Tests',
	#package : 'Spec2-Commander2-Tests'
}

{ #category : 'tests' }
CmUILeftPositionStrategyExtensionsTest >> testAddButtonToActionBar [
	| actionBar button |
	actionBar := SpActionBarPresenter new.
	button := SpButtonPresenter new.
	
	self assertEmpty: actionBar items.
	
	CmUILeftPositionStrategy new
		addButton: button toActionBar: actionBar.
		
	self assert: actionBar items size equals: 1.
	self assert: (actionBar items includesKey: #start).
	self assert: (actionBar items at: #start) size equals: 1.
	self assert: (actionBar items at: #start) anyOne equals: button
]

{ #category : 'tests' }
CmUILeftPositionStrategyExtensionsTest >> testAddButtonToToolbar [
	| toolbar button |
	toolbar := SpToolbarPresenter new.
	button := SpToolbarButtonPresenter new.
	
	self assertEmpty: toolbar items.
	
	CmUILeftPositionStrategy new
		addButton: button toToolbar: toolbar.
		
	self assert: toolbar leftItems size equals: 1.
	self assert: toolbar leftItems anyOne equals: button.
	self assertEmpty: toolbar rightItems
]
