Class {
	#name : 'SpContextInteractionModelTest',
	#superclass : 'SpCodeInteractionModelTest',
	#instVars : [
		'instanceVariableForTest'
	],
	#category : 'Spec2-Code-Tests',
	#package : 'Spec2-Code-Tests'
}

{ #category : 'accessing' }
SpContextInteractionModelTest >> classToTest [

	^ SpContextInteractionModel
]

{ #category : 'running' }
SpContextInteractionModelTest >> initializeInstance: anInteractionModel [

	| context |
	context := [
	           | tempVariableForTest |
	           instanceVariableForTest := 42.
	           tempVariableForTest := 43.
	           44 ] asContext.
	context step; step; step; step. "Perform the 2 assigments"
	anInteractionModel context: context
]

{ #category : 'tests' }
SpContextInteractionModelTest >> testBehavior [

	self assert: interactionModel behavior equals: self class
]

{ #category : 'tests' }
SpContextInteractionModelTest >> testBindingOf [

	self assert: (interactionModel bindingOf: #somethingNotExistent) isNil.
	self assert: (interactionModel bindingOf: #Object) isNotNil.
	self assert: (interactionModel bindingOf: #instanceVariableForTest) isNotNil.
	self assert: (interactionModel bindingOf: #tempVariableForTest) isNotNil
]

{ #category : 'tests' }
SpContextInteractionModelTest >> testCompile [

	| result |
	
	result := interactionModel compiler evaluate: 'instanceVariableForTest'.
	self assert: result equals: 42.
	instanceVariableForTest := 52.
	result := interactionModel compiler evaluate: 'instanceVariableForTest'.
	self assert: result equals: 52.

	result := interactionModel compiler evaluate: 'instanceVariableForTest := 62'.
	self assert: result equals: 62.
	result := interactionModel compiler evaluate: 'instanceVariableForTest'.
	self assert: result equals: 62.
	self assert: instanceVariableForTest equals: 62.

	result := interactionModel compiler evaluate: 'tempVariableForTest'.
	self assert: result equals: 43.
	result := interactionModel compiler evaluate: 'tempVariableForTest := 53'.
	self assert: result equals: 53.
	result := interactionModel compiler evaluate: 'tempVariableForTest'.
	self assert: result equals: 53
]

{ #category : 'tests' }
SpContextInteractionModelTest >> testDoItReceiver [

	self assert: interactionModel doItReceiver equals: self
]

{ #category : 'tests' }
SpContextInteractionModelTest >> testHasBindingOf [

	self deny: (interactionModel hasBindingOf: #somethingNotExistent).
	self assert: (interactionModel hasBindingOf: #Object).
	self assert: (interactionModel hasBindingOf: #instanceVariableForTest).
	self assert: (interactionModel hasBindingOf: #tempVariableForTest)
]
