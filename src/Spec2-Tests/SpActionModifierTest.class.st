Class {
	#name : 'SpActionModifierTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Tests-Core',
	#package : 'Spec2-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
SpActionModifierTest >> testActionModifier [

	self 
		assert: $x actionModifier 
		equals: ($x ctrl unix | $x ctrl win | $x command mac)
]
