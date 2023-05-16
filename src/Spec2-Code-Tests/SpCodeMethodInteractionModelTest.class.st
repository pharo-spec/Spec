Class {
	#name : #SpCodeMethodInteractionModelTest,
	#superclass : #SpCodeInteractionModelTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #accessing }
SpCodeMethodInteractionModelTest >> classToTest [

	^ SpCodeMethodInteractionModel
]

{ #category : #running }
SpCodeMethodInteractionModelTest >> initializeInstance: anInteractionModel [

	anInteractionModel method: self class >> #methodToTest
]

{ #category : #accessing }
SpCodeMethodInteractionModelTest >> methodToTest [
	| a b |
	
	a := 21.
	b := 2.
	
	^ a * b
]

{ #category : #tests }
SpCodeMethodInteractionModelTest >> testBehavior [

	self assert: interactionModel behavior equals: self class
]

{ #category : #tests }
SpCodeMethodInteractionModelTest >> testBindingOf [

	self assert: (interactionModel bindingOf: #somethingNotExistent) isNil.
	self assert: (interactionModel bindingOf: #Object) notNil
]

{ #category : #tests }
SpCodeMethodInteractionModelTest >> testDoItReceiver [

	self 
		assert: interactionModel doItReceiver 
		equals: self class
]

{ #category : #tests }
SpCodeMethodInteractionModelTest >> testHasBindingOf [

	self deny: (interactionModel hasBindingOf: #somethingNotExistent).
	self assert: (interactionModel hasBindingOf: #Object)
]
