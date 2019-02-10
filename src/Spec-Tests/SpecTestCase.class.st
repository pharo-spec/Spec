Class {
	#name : #SpecTestCase,
	#superclass : #TestCase,
	#instVars : [
		'window',
		'presenter'
	],
	#category : #'Spec-Tests-Utils'
}

{ #category : #running }
SpecTestCase >> classToTest [
	self subclassResponsibility
]

{ #category : #running }
SpecTestCase >> initializeTestedInstance [
]

{ #category : #running }
SpecTestCase >> openInstance [
	window := presenter openWithSpec
]

{ #category : #running }
SpecTestCase >> openInstance: aLayoutSelector [
	window := presenter openWithSpec: aLayoutSelector
]

{ #category : #accessing }
SpecTestCase >> presenter [
	^ presenter
]

{ #category : #running }
SpecTestCase >> setUp [
	super setUp.
	presenter := self classToTest new.
	self initializeTestedInstance
]

{ #category : #running }
SpecTestCase >> tearDown [
	window ifNotNil: [ window delete ].
	super tearDown
]

{ #category : #accessing }
SpecTestCase >> widget [
	
	^ self adapter widget
]
