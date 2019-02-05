Class {
	#name : #SpecTestCase,
	#superclass : #TestCase,
	#instVars : [
		'window',
		'testedInstance'
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
	window := testedInstance openWithSpec
]

{ #category : #running }
SpecTestCase >> openInstance: aLayoutSelector [
	window := testedInstance openWithSpec: aLayoutSelector
]

{ #category : #running }
SpecTestCase >> setUp [
	super setUp.
	testedInstance := self classToTest new.
	self initializeTestedInstance
]

{ #category : #running }
SpecTestCase >> tearDown [
	window ifNotNil: [ window delete ].
	super tearDown
]
