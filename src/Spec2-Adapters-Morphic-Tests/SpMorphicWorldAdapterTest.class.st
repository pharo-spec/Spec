Class {
	#name : 'SpMorphicWorldAdapterTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Adapters-Morphic-Tests',
	#package : 'Spec2-Adapters-Morphic-Tests'
}

{ #category : 'tests' }
SpMorphicWorldAdapterTest >> testContentFillsTheWorldWhenAdded [
	"The world is laid out by events (e.g. the mouse entering it), not by the display cycle: its content must fill it as soon as it is added"

	| world content |
	world := Morph new
		         layoutPolicy: ProportionalLayout new;
		         extent: 300 @ 200;
		         yourself.
	content := Morph new.

	SpMorphicWorldAdapter new add: content toWindow: world.

	self assert: content bounds equals: world bounds
]
