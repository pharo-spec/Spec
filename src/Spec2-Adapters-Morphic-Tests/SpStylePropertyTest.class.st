Class {
	#name : #SpStylePropertyTest,
	#superclass : #TestCase,
	#category : #'Spec2-Adapters-Morphic-Tests'
}

{ #category : #tests }
SpStylePropertyTest >> testMergeWith [
	| p1 p2 p3 |
	
	p1 := SpStyleGeometry new
		extent: 20@20;
		yourself.
	p2 := SpStyleGeometry new
		extent: 40@40;
		yourself.
		
	p3 := p1, p2.
	
	self assert: p3 extent equals: 40@40.
	
]

{ #category : #tests }
SpStylePropertyTest >> testMergeWithFontRemovePredefinedFont [
	| p1 p2 p3 |
	
	p1 := SpStyleFont new
		predefinedFont: #default;
		yourself.
	p2 := SpStyleFont new
		name: 'Source Code Pro';
		size: 10;
		yourself.
		
	p3 := p1, p2.
	
	self assert: p3 predefinedFont isNil.
	
]
