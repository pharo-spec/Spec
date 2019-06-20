"
SUnit tests for SpecWindow
"
Class {
	#name : #SpWindowTest,
	#superclass : #TestCase,
	#instVars : [
		'windowPresenter'
	],
	#category : #'Spec-Tests-Core-Support'
}

{ #category : #tests }
SpWindowTest >> testAboutText [
	| presenter window |
	windowPresenter := WindowPresenter new.
	windowPresenter aboutText: 'test'.
	self assert: windowPresenter aboutText equals: 'test'.
	windowPresenter close.

	presenter := TextPresenter new.
	[ window := presenter openWithSpec.
	presenter withWindowDo: [ :w | w aboutText: 'test2' ].
	self assert: presenter window aboutText equals: 'test2' ]
		ensure: [ window ifNotNil: #delete ]
]

{ #category : #tests }
SpWindowTest >> testIsDisplayed [
	"Test for case: 16800 -> ask a SpecWindow for #isDisplayed always returns true"
	
	windowPresenter := TextPresenter new openWithSpec.
	self assert: (windowPresenter isDisplayed).
	
	windowPresenter window minimize.	
	self assert: (windowPresenter isDisplayed).
		
	windowPresenter window close.
	self assert: (windowPresenter isDisplayed not).

	
]

{ #category : #tests }
SpWindowTest >> testTitle [
	| presenter window |
	windowPresenter := TextPresenter new openWithSpec.

	self assert: windowPresenter isDisplayed.
	self assert: windowPresenter title equals: 'Text'.
	windowPresenter close.

	presenter := TextPresenter new.
	[ window := presenter openWithSpec.
	presenter withWindowDo: [ :w | w title: 'Test Window' ].
	self assert: presenter window title equals: 'Test Window' ]
		ensure: [ window ifNotNil: #delete ]
]
