"
SUnit tests for SpecWindow
"
Class {
	#name : #SpecWindowTest,
	#superclass : #TestCase,
	#instVars : [
		'windowPresenter'
	],
	#category : #'Spec-Tests-Core-Support'
}

{ #category : #running }
SpecWindowTest >> setUp [
	super setUp.
	windowPresenter := TextPresenter new openWithSpec
]

{ #category : #running }
SpecWindowTest >> tearDown [
	(windowPresenter isNotNil and: [ windowPresenter isDisplayed ]) ifTrue: [ windowPresenter close ].
	super tearDown
]

{ #category : #tests }
SpecWindowTest >> testIsDisplayed [
	"Test for case: 16800 -> ask a SpecWindow for #isDisplayed always returns true"
	
	self assert: (windowPresenter isDisplayed).
	
	windowPresenter window minimize.	
	self assert: (windowPresenter isDisplayed).
		
	windowPresenter window close.
	self assert: (windowPresenter isDisplayed not).

	
]

{ #category : #tests }
SpecWindowTest >> testTitle [
	self assert: windowPresenter isDisplayed.
	self assert: windowPresenter title equals: 'Text'.
	
	windowPresenter title: 'Test Window'.
	self assert: windowPresenter title equals: 'Test Window' 
]
