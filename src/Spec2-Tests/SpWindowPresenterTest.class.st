Class {
	#name : #SpWindowPresenterTest,
	#superclass : #SpSpecTest,
	#category : #'Spec2-Tests-Core'
}

{ #category : #accessing }
SpWindowPresenterTest >> classToTest [

	^ SpWindowPresenter
]

{ #category : #initialization }
SpWindowPresenterTest >> initializeTestedInstance [
	presenter presenter: SpLabelPresenter new
]

{ #category : #utilities }
SpWindowPresenterTest >> openInstance [
	window ifNil: [ window := presenter openWithSpecLayout: SpLabelPresenter defaultSpec ]
]

{ #category : #tests }
SpWindowPresenterTest >> testInitialPosition [
	presenter initialPosition: 100 @ 100.
	self openInstance.
	self assert: window adapter widget position equals: 100 @ 100
]

{ #category : #tests }
SpWindowPresenterTest >> testIsClosed [
	self assert: presenter isClosed.
	self openInstance.
	self deny: presenter isClosed.
	presenter close.
	self assert: presenter isClosed
]

{ #category : #tests }
SpWindowPresenterTest >> testIsTopWindow [

	self deny: presenter isTopWindow.
	self openInstance.
	presenter takeKeyboardFocus.
	self assert: presenter isTopWindow.
	presenter close.
	self deny: presenter isTopWindow
]

{ #category : #tests }
SpWindowPresenterTest >> testResize [
	
	self openInstance.

	self 
		deny: presenter adapter windowSize 
		equals: 600@600.
	presenter resize: 600@600.
	self 
		assert: presenter adapter windowSize
		equals: 600@600
]

{ #category : #tests }
SpWindowPresenterTest >> testWhenClosedDo [
	| closed |
	closed := false.
	presenter whenClosedDo: [ closed := true ].
	self openInstance.
	presenter close.
	self assert: closed
]

{ #category : #tests }
SpWindowPresenterTest >> testWhenOpenedDo [
	| opened |
	opened := false.
	presenter whenOpenedDo: [ opened := true ].
	self openInstance.
	self assert: opened
]

{ #category : #tests }
SpWindowPresenterTest >> testWhenWillCloseDo [
	| willClose closed |

	willClose := false.
	closed := false.
	presenter whenWillCloseDo: [ willClose := true ].
	presenter whenClosedDo: [ closed := willClose ].
	self openInstance.
	presenter close.
	self assert: willClose.
	self assert: closed
]
