"
SUnit tests for SpecWindow
"
Class {
	#name : 'SpWindowTest',
	#superclass : 'TestCase',
	#instVars : [
		'windowPresenter'
	],
	#category : 'Spec2-Tests-Core-Support',
	#package : 'Spec2-Tests',
	#tag : 'Core-Support'
}

{ #category : 'tests' }
SpWindowTest >> testAboutText [

	| presenter window |
	windowPresenter := SpWindowPresenter new.
	windowPresenter aboutText: 'test'.
	self assert: windowPresenter aboutText equals: 'test'.
	windowPresenter close.

	presenter := SpTextPresenter new.
	[ 
	window := presenter open.
	presenter withWindowDo: [ :w | w aboutText: 'test2' ].
	self assert: presenter window aboutText equals: 'test2' ] ensure: [ 
		window ifNotNil: #delete ]
]

{ #category : 'tests' }
SpWindowTest >> testAllowedToClose [

	| application appWindow |
	application := SpApplication new.
	windowPresenter := (application newPresenter: SpTextPresenter) open.
	appWindow := windowPresenter window.

	windowPresenter askOkToClose: true.
	self 
		deny: appWindow model isNil
		description: 'It tests the window presenter model is not nil by default'.
	self 
		assert: appWindow allowedToClose 
		description: 'It tests the window presenter is allowed to close if its application window does have a model'.
	windowPresenter askOkToClose: false.
	self 
		assert: appWindow allowedToClose
		description: 'It tests the window presenter is allowed to close if its application window does NOT have a model'.

	appWindow close.
	
	self deny: (application windows includes: windowPresenter).
	self assert: application windows isEmpty
]

{ #category : 'tests' }
SpWindowTest >> testCloseWindowRemovesItFromApplicationWindowCollection [

	| application |
	application := SpApplication new.
	windowPresenter := (application newPresenter: SpButtonPresenter) open.
	windowPresenter window close.
	self deny: (application windows includes: windowPresenter).
	self assert: application windows isEmpty
]

{ #category : 'tests' }
SpWindowTest >> testIsDisplayed [

	"Test for case: 16800 -> ask a SpecWindow for #isDisplayed always returns true"

	windowPresenter := SpTextPresenter new open.
	self assert: windowPresenter isDisplayed.

	windowPresenter window minimize.
	self assert: windowPresenter isDisplayed.

	windowPresenter window close.
	self assert: windowPresenter isDisplayed not
]

{ #category : 'tests' }
SpWindowTest >> testTitle [

	| presenter window |
	windowPresenter := SpTextPresenter new open.

	self assert: windowPresenter isDisplayed.
	self assert: windowPresenter title equals: 'Text'.
	windowPresenter close.

	presenter := SpTextPresenter new.
	[ 
	window := presenter open.
	presenter withWindowDo: [ :w | w title: 'Test Window' ].
	self assert: presenter window title equals: 'Test Window' ] ensure: [ 
		window ifNotNil: #delete ]
]
