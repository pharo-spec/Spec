Class {
	#name : #SpCodeObjectInteractionModelTest,
	#superclass : #SpCodeInteractionModelTest,
	#instVars : [
		'objectToTest',
		'instanceVariableForTest'
	],
	#category : #'Spec2-Code-Tests'
}

{ #category : #accessing }
SpCodeObjectInteractionModelTest >> classToTest [

	^ SpCodeObjectInteractionModel
]

{ #category : #running }
SpCodeObjectInteractionModelTest >> initializeInstance: anInteractionModel [

	anInteractionModel object: self objectToTest
]

{ #category : #accessing }
SpCodeObjectInteractionModelTest >> objectToTest [

	^ objectToTest ifNil: [ objectToTest := self ]
]

{ #category : #running }
SpCodeObjectInteractionModelTest >> tearDown [

	objectToTest := nil.
	super tearDown
]

{ #category : #tests }
SpCodeObjectInteractionModelTest >> testBehavior [

	self assert: interactionModel behavior equals: objectToTest class
]

{ #category : #tests }
SpCodeObjectInteractionModelTest >> testBindingOf [

	self assert: (interactionModel bindingOf: #somethingNotExistent) isNil.
	self assert: (interactionModel bindingOf: #Object) isNil
]

{ #category : #tests }
SpCodeObjectInteractionModelTest >> testDoItReceiver [

	self assert: interactionModel doItReceiver equals: objectToTest
]

{ #category : #tests }
SpCodeObjectInteractionModelTest >> testHasBindingOf [

	self deny: (interactionModel hasBindingOf: #somethingNotExistent).
	self deny: (interactionModel hasBindingOf: #Object)
]
