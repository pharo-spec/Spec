Class {
	#name : #SpCodeNullInteractionModelTest,
	#superclass : #SpCodeInteractionModelTest,
	#category : #'Spec2-Code-Tests'
}

{ #category : #accessing }
SpCodeNullInteractionModelTest >> classToTest [

	^ SpCodeNullInteractionModel
]

{ #category : #tests }
SpCodeNullInteractionModelTest >> testBehavior [

	self assert: interactionModel behavior isNil
]

{ #category : #tests }
SpCodeNullInteractionModelTest >> testBindingOf [

	self assert: (interactionModel bindingOf: #somethingNotExistent) isNil.
	self assert: (interactionModel bindingOf: #Object) isNil
]

{ #category : #tests }
SpCodeNullInteractionModelTest >> testHasBindingOf [

	self deny: (interactionModel hasBindingOf: #somethingNotExistent).
	self deny: (interactionModel hasBindingOf: #Object)
]
