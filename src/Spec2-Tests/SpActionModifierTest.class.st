Class {
	#name : #SpActionModifierTest,
	#superclass : #TestCase,
	#category : #'Spec2-Tests-Core'
}

{ #category : #tests }
SpActionModifierTest >> testActionModifier [

	self 
		assert: $x actionModifier 
		equals: ($x ctrl unix | $x ctrl win | $x command mac)
]
