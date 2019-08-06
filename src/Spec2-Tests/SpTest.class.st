Class {
	#name : #SpTest,
	#superclass : #TestCase,
	#instVars : [
		'window',
		'presenter'
	],
	#category : #'Spec2-Tests-Utils'
}

{ #category : #assertions }
SpTest >> assertEvent: anEventName isRaisedInPresenter: aPresenter whenDoing: aBlock [
	
	self
		assertWith: [ :times | times > 0 ]
		timesRaisedEvent: anEventName
		inPresenter: aPresenter
		whenDoing: aBlock
]

{ #category : #assertions }
SpTest >> assertWith: assertionBlock timesRaisedEvent: anEventName inPresenter: aPresenter whenDoing: actionBlock [
	
	| timesCalled |
	timesCalled := 0.
	aPresenter perform: anEventName with: [ timesCalled := timesCalled + 1 ].
	actionBlock value.
	assertionBlock value: timesCalled
]

{ #category : #running }
SpTest >> classToTest [
	self subclassResponsibility
]

{ #category : #assertions }
SpTest >> denyEvent: anEventName isRaisedInPresenter: aPresenter whenDoing: aBlock [
	
	self
		assertWith: [ :times | times = 0 ]
		timesRaisedEvent: anEventName
		inPresenter: aPresenter
		whenDoing: aBlock
]

{ #category : #running }
SpTest >> initializeTestedInstance [
]

{ #category : #running }
SpTest >> openInstance [
	window ifNil: [ window := presenter openWithSpec ]
]

{ #category : #running }
SpTest >> openInstance: aLayoutSelector [
	window := presenter openWithSpec: aLayoutSelector
]

{ #category : #accessing }
SpTest >> presenter [
	^ presenter
]

{ #category : #running }
SpTest >> setUp [
	super setUp.
	presenter := self classToTest new.
	self initializeTestedInstance
]

{ #category : #running }
SpTest >> tearDown [
	window ifNotNil: [ window delete ].
	super tearDown
]

{ #category : #accessing }
SpTest >> widget [
	
	^ self adapter widget
]
