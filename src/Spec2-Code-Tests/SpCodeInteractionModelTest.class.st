Class {
	#name : #SpCodeInteractionModelTest,
	#superclass : #TestCase,
	#instVars : [
		'interactionModel'
	],
	#category : #'Spec2-Code-Tests'
}

{ #category : #testing }
SpCodeInteractionModelTest class >> isAbstract [

	^ super isAbstract or: [ self = SpCodeInteractionModelTest ]
]

{ #category : #accessing }
SpCodeInteractionModelTest >> classToTest [

	^ self subclassResponsibility
]

{ #category : #running }
SpCodeInteractionModelTest >> initializeInstance: anInteractionModel [
]

{ #category : #running }
SpCodeInteractionModelTest >> setUp [

	super setUp.
	interactionModel := self classToTest new.
	self initializeInstance: interactionModel
]

{ #category : #tests }
SpCodeInteractionModelTest >> testBehavior [

	self subclassResponsibility
]

{ #category : #tests }
SpCodeInteractionModelTest >> testBindingOf [

	self subclassResponsibility
]

{ #category : #tests }
SpCodeInteractionModelTest >> testDoItReceiver [

	self assert: interactionModel doItReceiver isNil
]

{ #category : #tests }
SpCodeInteractionModelTest >> testHasBindingOf [

	self subclassResponsibility
]
