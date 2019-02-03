Class {
	#name : #GridLayoutTests,
	#superclass : #TestCase,
	#category : #'Spec-MorphicAdapters-Layout'
}

{ #category : #tests }
GridLayoutTests >> testLayoutIn [
	| panel label1 morph1 label2 morph2 layout |
	
	layout := GridLayout new.
	panel := Morph new
		extent: 100@100;
		addMorphBack: ((label1 := Morph new)
			height: 20;
			layoutProperties: (GridLayoutProperties new 
				position: 1@1;
				yourself)); 
		addMorphBack: ((morph1 := Morph new) 
			height: 20;
			layoutProperties: (GridLayoutProperties new 
				position: 2@1;
				yourself)); 
		addMorphBack: ((label2 := Morph new) 
			height: 20;
			layoutProperties: (GridLayoutProperties new 
				position: 1@2;
				yourself)); 
		addMorphBack: ((morph2 := Morph new) 
			height: 20;
			layoutProperties: (GridLayoutProperties new 
				position: 2@2;
				yourself)); 
		yourself.
	
	layout layout: panel in: (0@0 corner: 100@100).
	
	self assert: label1 bounds equals: (0@0 corner: 50@20).
	self assert: morph1 bounds equals: (50@0 corner: 100@20).	
	self assert: label2 bounds equals: (0@20 corner: 50@40).
	self assert: morph2 bounds equals: (50@20 corner: 100@40)
]
