Class {
	#name : #SpAbstractAdapterTest,
	#superclass : #ParametrizedTestCase,
	#instVars : [
		'presenter',
		'specInitializationStrategy',
		'window',
		'backendForTest'
	],
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #testing }
SpAbstractAdapterTest class >> isAbstract [ 
	^ self == SpAbstractAdapterTest
]

{ #category : #testing }
SpAbstractAdapterTest class >> testParameters [ 

	^ ParametrizedTestMatrix new
		forSelector: #specInitializationStrategy
			addOptions: { [ SpInitializationStrategy beforeTest ]. [ SpInitializationStrategy afterTest ] };
		forSelector: #backendForTest
			addOptions: { "SpMorphicBackendForTest. "GtkBackendForTest };
		yourself
]

{ #category : #accessing }
SpAbstractAdapterTest >> adapter [

	"Force opening the spec instance here.
	The action should have been correctly configured before
	depending on the spec initialization strategy"
	backendForTest openInstanceOf: self.
	^ presenter adapter
]

{ #category : #asserting }
SpAbstractAdapterTest >> assertIcon: anIcon equals: aForm [ 
	
	backendForTest assertIcon: anIcon equals: aForm
]

{ #category : #accessing }
SpAbstractAdapterTest >> backendForTest: aClass [ 
	
	backendForTest := aClass new
]

{ #category : #accessing }
SpAbstractAdapterTest >> classToTest [

	^ self subclassResponsibility
]

{ #category : #'utilities - emulation' }
SpAbstractAdapterTest >> emulateCenterClick [

	self emulateClick: MouseButtonEvent blueButton
]

{ #category : #'utilities - emulation' }
SpAbstractAdapterTest >> emulateClick: mouseButtonCode [

	backendForTest emulateClick: mouseButtonCode onTest: self
]

{ #category : #'utilities - emulation' }
SpAbstractAdapterTest >> emulateLeftClick [

	self emulateClick: MouseButtonEvent redButton
]

{ #category : #'utilities - emulation' }
SpAbstractAdapterTest >> emulateRightClick [

	self emulateClick: MouseButtonEvent yellowButton
]

{ #category : #initialization }
SpAbstractAdapterTest >> initializeTestedInstance [
]

{ #category : #utilities }
SpAbstractAdapterTest >> openInstance [

	backendForTest openInstanceOf: self 

]

{ #category : #private }
SpAbstractAdapterTest >> performTest [
	backendForTest
		runTest: [ presenter := self classToTest new.
			self initializeTestedInstance.
			super performTest ]
]

{ #category : #running }
SpAbstractAdapterTest >> prepareToRunAgain [
	"Redefined because setup is cancelled in this class"

	self tearDown.
	super setUp
]

{ #category : #accessing }
SpAbstractAdapterTest >> presenter [
	^ presenter
]

{ #category : #running }
SpAbstractAdapterTest >> runCase [
	self resources do: [ :each | each availableFor: self ].
	testSelector printToStdout.
	[ super setUp.
	self performTest ]
		ensure: [ self tearDown.
			self cleanUpInstanceVariables ]
]

{ #category : #running }
SpAbstractAdapterTest >> setUp [
	super setUp.	"This super is useless but it's to make the release tests happy."
	self error: 'Do not override me.... use #initializeTestedInstance'
]

{ #category : #accessing }
SpAbstractAdapterTest >> specInitializationStrategy: aStrategy [
	
	specInitializationStrategy := aStrategy
]

{ #category : #running }
SpAbstractAdapterTest >> tearDown [
	window ifNotNil: [ window delete ].
	super tearDown
]

{ #category : #tests }
SpAbstractAdapterTest >> testHidePresenterHidesWidget [
	
	self presenter hide.
	self deny: self adapter isVisible
]

{ #category : #tests }
SpAbstractAdapterTest >> testShowPresenterShowsWidget [
	
	self presenter show.
	self assert: self adapter isVisible
]

{ #category : #tests }
SpAbstractAdapterTest >> testVisibilityWithBlock [
	presenter visibleIf: [ true ].
	self assert: self adapter isVisible
]

{ #category : #tests }
SpAbstractAdapterTest >> testVisibilityWithBlockThatReturnsFalse [

	presenter visibleIf: [ false ].
	self deny: self adapter isVisible
]

{ #category : #accessing }
SpAbstractAdapterTest >> widget [

	^ self adapter widget
]

{ #category : #accessing }
SpAbstractAdapterTest >> window [
	^ window
]

{ #category : #accessing }
SpAbstractAdapterTest >> window: aWindowPresenter [ 
	window := aWindowPresenter
]
