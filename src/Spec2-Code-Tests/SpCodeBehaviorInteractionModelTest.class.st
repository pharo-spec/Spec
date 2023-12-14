Class {
	#name : 'SpCodeBehaviorInteractionModelTest',
	#superclass : 'SpCodeInteractionModelTest',
	#category : 'Spec2-Code-Tests',
	#package : 'Spec2-Code-Tests'
}

{ #category : 'accessing' }
SpCodeBehaviorInteractionModelTest >> behaviorToTest [

	^ SpCodePresenter
]

{ #category : 'accessing' }
SpCodeBehaviorInteractionModelTest >> classToTest [

	^ SpCodeBehaviorInteractionModel
]

{ #category : 'running' }
SpCodeBehaviorInteractionModelTest >> initializeInstance: anInteractionModel [

	anInteractionModel behavior: self behaviorToTest
]

{ #category : 'tests' }
SpCodeBehaviorInteractionModelTest >> testBehavior [

	self assert: interactionModel behavior equals: self behaviorToTest
]

{ #category : 'tests' }
SpCodeBehaviorInteractionModelTest >> testBindingOf [

	self assert: (interactionModel bindingOf: #somethingNotExistent) isNil.
	
	self deny: (interactionModel bindingOf: #Object) isNil.
	self assert: (interactionModel bindingOf: #Object) value equals: Object
]

{ #category : 'tests' }
SpCodeBehaviorInteractionModelTest >> testHasBindingOf [

	self deny: (interactionModel hasBindingOf: #somethingNotExistent).
	self assert: (interactionModel hasBindingOf: #Object)
]
