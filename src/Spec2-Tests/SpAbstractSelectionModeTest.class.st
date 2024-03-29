Class {
	#name : 'SpAbstractSelectionModeTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'Spec2-Tests-Layout',
	#package : 'Spec2-Tests',
	#tag : 'Layout'
}

{ #category : 'testing' }
SpAbstractSelectionModeTest class >> isAbstract [
	^ self = SpAbstractSelectionModeTest
]

{ #category : 'testing' }
SpAbstractSelectionModeTest class >> shouldInheritSelectors [
	^ true
]

{ #category : 'running' }
SpAbstractSelectionModeTest >> setUp [
	super setUp.
	presenter := SpListPresenter new.
	presenter items: (1 to: 10)
]

{ #category : 'running' }
SpAbstractSelectionModeTest >> tearDown [ 

	presenter delete.
	super tearDown
]

{ #category : 'tests' }
SpAbstractSelectionModeTest >> testSubscriptionsAreTransfered [
	self subclassResponsibility
]
