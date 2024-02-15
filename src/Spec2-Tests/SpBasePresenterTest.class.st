Class {
	#name : 'SpBasePresenterTest',
	#superclass : 'SpBaseTest',
	#instVars : [
		'presenter',
		'window'
	],
	#category : 'Spec2-Tests-Utils',
	#package : 'Spec2-Tests',
	#tag : 'Utils'
}

{ #category : 'testing' }
SpBasePresenterTest class >> isAbstract [

	^ self = SpBasePresenterTest
]

{ #category : 'accessing' }
SpBasePresenterTest >> adapter [

	^ self subclassResponsibility
]

{ #category : 'assertions' }
SpBasePresenterTest >> assertEvent: anEventName isRaisedInPresenter: aPresenter whenDoing: aBlock [
	
	self
		assertWith: [ :times | times > 0 ]
		timesRaisedEvent: anEventName
		inPresenter: aPresenter
		whenDoing: aBlock
]

{ #category : 'assertions' }
SpBasePresenterTest >> assertWith: assertionBlock timesRaisedEvent: anEventName inPresenter: aPresenter whenDoing: actionBlock [
	
	| timesCalled |
	timesCalled := 0.
	aPresenter perform: anEventName with: [ timesCalled := timesCalled + 1 ].
	actionBlock value.
	assertionBlock value: timesCalled
]

{ #category : 'accessing' }
SpBasePresenterTest >> classToTest [
	self subclassResponsibility
]

{ #category : 'assertions' }
SpBasePresenterTest >> denyEvent: anEventName isRaisedInPresenter: aPresenter whenDoing: aBlock [
	
	self
		assertWith: [ :times | times = 0 ]
		timesRaisedEvent: anEventName
		inPresenter: aPresenter
		whenDoing: aBlock
]

{ #category : 'initialization' }
SpBasePresenterTest >> initializeTestedInstance [
]

{ #category : 'utilities' }
SpBasePresenterTest >> openInstance [

	window ifNil: [ window := presenter open ]
]

{ #category : 'accessing' }
SpBasePresenterTest >> presenter [
	^ presenter
]

{ #category : 'running' }
SpBasePresenterTest >> setUp [
	super setUp.
	presenter := self classToTest newApplication: self application.
	self initializeTestedInstance
]

{ #category : 'running' }
SpBasePresenterTest >> tearDown [
	window ifNotNil: [ window delete ].
	super tearDown
]

{ #category : 'tests' }
SpBasePresenterTest >> testNewPresenterIsNotBuilt [
	self deny: presenter isBuilt
]

{ #category : 'tests' }
SpBasePresenterTest >> testNewPresenterIsNotDisplayed [
	self deny: presenter isDisplayed
]

{ #category : 'tests' }
SpBasePresenterTest >> testNonOpenPresenterDoesNotRaiseBuiltEvent [
	| built |
	built := false.
	presenter whenBuiltDo: [ built := true ].
	self deny: built
]

{ #category : 'tests' }
SpBasePresenterTest >> testNonOpenPresenterDoesNotRaiseDisplayedEvent [
	| displayed |
	displayed := false.
	presenter whenDisplayDo: [ displayed := true ].
	self deny: displayed
]

{ #category : 'tests' }
SpBasePresenterTest >> testOpenPresenterIsBuilt [
	self openInstance.
	self assert: presenter isBuilt
]

{ #category : 'tests' }
SpBasePresenterTest >> testOpenPresenterIsDisplayed [
	self openInstance.
	self assert: presenter isDisplayed
]

{ #category : 'tests' }
SpBasePresenterTest >> testOpenPresenterRaisesBuiltEvent [
	| built |
	built := false.
	presenter whenBuiltDo: [ built := true ].
	self openInstance.
	self assert: built
]

{ #category : 'tests' }
SpBasePresenterTest >> testOpenPresenterRaisesDisplayEvent [
	| displayed |
	displayed := false.
	presenter whenDisplayDo: [ displayed := true ].
	self openInstance.
	self assert: displayed
]

{ #category : 'tests' }
SpBasePresenterTest >> testRebuildPresenterDoNotLetReferencesInAnnouncer [

	| oldSize newSize |
	presenter build.
	oldSize := presenter announcer subscriptions subscriptions size.
	"rebuild"
	presenter build.
	newSize := presenter announcer subscriptions subscriptions size.

	self assert: oldSize equals: newSize
]

{ #category : 'accessing' }
SpBasePresenterTest >> widget [
	
	^ self adapter widget
]
