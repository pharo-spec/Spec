Class {
	#name : #SpPresenterFocusOrderTest,
	#superclass : #TestCase,
	#instVars : [
		'mock'
	],
	#category : #'Spec2-Backend-Tests'
}

{ #category : #running }
SpPresenterFocusOrderTest >> tearDown [

	mock ifNotNil: [ 
		mock hasWindow ifTrue: [ 
			mock window close ] ]
]

{ #category : #tests }
SpPresenterFocusOrderTest >> testFocusRotationForward [

	mock := SpMockFocusOrderPresenter new
		openWithSpec;
		yourself.
		
	"Focus first"
	mock takeKeyboardFocus.
	self assert: (mock presenterAt: #firstPresenter) adapter widget hasKeyboardFocus.
	"Focus second"
	mock type: Character tab asString.
	self assert: (mock presenterAt: #firstPresenter) adapter widget hasKeyboardFocus.
	"Focus third"
	mock type: Character tab asString.
	self assert: (mock presenterAt: #thirdPresenter) adapter widget hasKeyboardFocus.
	"Focus first again"
	mock type: Character tab asString.
	self assert: (mock presenterAt: #firstPresenter) adapter widget hasKeyboardFocus
]

{ #category : #tests }
SpPresenterFocusOrderTest >> testTakeKeyboardFocus [

	mock := SpMockFocusOrderPresenter new
		openWithSpec;
		yourself.
		
	"Focus first"
	mock takeKeyboardFocus.
	self assert: (mock presenterAt: #firstPresenter) adapter widget hasKeyboardFocus.
	"Focus second"
	(mock presenterAt: #secondPresenter) takeKeyboardFocus.
	self deny: (mock presenterAt: #firstPresenter) adapter widget hasKeyboardFocus.
	self assert: (mock presenterAt: #secondPresenter) adapter widget hasKeyboardFocus.
	"Focus first again"
	(mock presenterAt: #firstPresenter) takeKeyboardFocus.
	self assert: (mock presenterAt: #firstPresenter) adapter widget hasKeyboardFocus.
	self deny: (mock presenterAt: #secondPresenter) adapter widget hasKeyboardFocus.

]
