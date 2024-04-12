Class {
	#name : 'SpCodeScriptingInteractionModelTest',
	#superclass : 'SpCodeInteractionModelTest',
	#category : 'Spec2-Code-Tests',
	#package : 'Spec2-Code-Tests'
}

{ #category : 'testing' }
SpCodeScriptingInteractionModelTest class >> shouldInheritSelectors [
	
	^ true
]

{ #category : 'accessing' }
SpCodeScriptingInteractionModelTest >> classToTest [

	^ SpCodeScriptingInteractionModel
]

{ #category : 'initialization' }
SpCodeScriptingInteractionModelTest >> initializeInstance: anInteractionModel [

	anInteractionModel addBinding: (WorkspaceVariable  key: #testVar value: 42)
]

{ #category : 'tests' }
SpCodeScriptingInteractionModelTest >> testAddBinding [

	interactionModel addBinding: (WorkspaceVariable key: #testVar2 value: 42).
	self assert: interactionModel bindings size equals: 2
]

{ #category : 'tests' }
SpCodeScriptingInteractionModelTest >> testBehavior [

	self assert: interactionModel behavior isNil
]

{ #category : 'tests' }
SpCodeScriptingInteractionModelTest >> testBindingOf [

	"auto create of bindings on demand (it will always answer a value)"
	self assert: (interactionModel bindingOf: #somethingNotExistent) isNotNil.
	self assert: (interactionModel bindingOf: #somethingNotExistent) value isNil.
	"... even if it is an Object variable... is this correct?"
	self assert: (interactionModel bindingOf: #Object) isNotNil.
	self assert: (interactionModel bindingOf: #Object) value isNil.
	"and of course it will answer our added bindings"
	self assert: (interactionModel bindingOf: #testVar) isNotNil.
	self assert: (interactionModel bindingOf: #testVar) value equals: 42
	
	
]

{ #category : 'tests' }
SpCodeScriptingInteractionModelTest >> testHasBindingOf [

	self deny: (interactionModel hasBindingOf: #somethingNotExistent).
	self deny: (interactionModel hasBindingOf: #Object).

	self assert: (interactionModel hasBindingOf: #testVar)	
]

{ #category : 'tests' }
SpCodeScriptingInteractionModelTest >> testRemoveBinding [

	interactionModel removeBinding: (WorkspaceVariable key: #testVar).
	self assert: interactionModel bindings isEmpty
]

{ #category : 'tests' }
SpCodeScriptingInteractionModelTest >> testVariableBindings [

	"this is used in some contexts, but it is just a synonym"
	self 
		assert: interactionModel variableBindings 
		equals: interactionModel bindings
]
