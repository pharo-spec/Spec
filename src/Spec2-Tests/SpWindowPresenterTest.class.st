Class {
	#name : 'SpWindowPresenterTest',
	#superclass : 'SpSpecTest',
	#category : 'Spec2-Tests-Core',
	#package : 'Spec2-Tests',
	#tag : 'Core'
}

{ #category : 'accessing' }
SpWindowPresenterTest >> classToTest [

	^ SpWindowPresenter
]

{ #category : 'initialization' }
SpWindowPresenterTest >> initializeTestedInstance [

	presenter presenter: SpLabelPresenter new
]

{ #category : 'utilities' }
SpWindowPresenterTest >> openInstance [

	window ifNil: [ 
		window := presenter openWithLayout: SpLabelPresenter defaultLayout ]
]

{ #category : 'tests' }
SpWindowPresenterTest >> testBeNotResizeable [
	
	self openInstance.

	self assert: presenter adapter windowIsResizable.
	presenter beNotResizable.
	self deny: presenter adapter windowIsResizable.

]

{ #category : 'tests' }
SpWindowPresenterTest >> testInitialPosition [
	presenter initialPosition: 100 @ 100.
	self openInstance.
	self assert: window adapter widget position equals: 100 @ 100
]

{ #category : 'tests' }
SpWindowPresenterTest >> testIsClosed [
	self assert: presenter isClosed.
	self openInstance.
	self deny: presenter isClosed.
	presenter close.
	self assert: presenter isClosed
]

{ #category : 'tests' }
SpWindowPresenterTest >> testIsTopWindow [

	self deny: presenter isTopWindow.
	self openInstance.
	presenter takeKeyboardFocus.
	self assert: presenter isTopWindow.
	presenter close.
	self deny: presenter isTopWindow
]

{ #category : 'tests' }
SpWindowPresenterTest >> testRebuildPresenterDoNotLetReferencesInAnnouncer [
	| oldSize newSize |
	
	presenter buildWithSpecLayout: SpLabelPresenter defaultLayout.
	oldSize := presenter announcer subscriptions subscriptions size.
	"rebuild"
	presenter rebuildWithSpecLayout: SpLabelPresenter defaultLayout.
	newSize := presenter announcer subscriptions subscriptions size.
	
	self assert: oldSize equals: newSize
]

{ #category : 'tests' }
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

{ #category : 'tests' }
SpWindowPresenterTest >> testUsingAsWindowCanOverrideTitle [
	| windowPresenter |
	
	windowPresenter := SpLabelPresenter new asWindow.
	[ windowPresenter open ]
	ensure: [ windowPresenter close ].
	self deny: windowPresenter title equals: 'Title Test'.
	
	windowPresenter := SpLabelPresenter new asWindow.
	windowPresenter title: 'Title Test'.
	[ windowPresenter open ]
	ensure: [ windowPresenter close ].
	
	self assert: windowPresenter title equals: 'Title Test'
]

{ #category : 'tests' }
SpWindowPresenterTest >> testWhenClosedDo [
	| closed |
	closed := false.
	presenter whenClosedDo: [ closed := true ].
	self openInstance.
	presenter close.
	self assert: closed
]

{ #category : 'tests' }
SpWindowPresenterTest >> testWhenOpenedDo [
	| opened |
	opened := false.
	presenter whenOpenedDo: [ opened := true ].
	self openInstance.
	self assert: opened
]

{ #category : 'tests' }
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
