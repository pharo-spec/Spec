Class {
	#name : #DiffBuilderTest,
	#superclass : #TestCase,
	#category : #'Spec2-Code-Diff-Tests'
}

{ #category : #tests }
DiffBuilderTest >> testDiffFromTo [
	| fileA fileB patch |
	
	fileA := 'ABCABBA'.
	fileB := 'CBABAC'.
	
	patch := DiffBuilder new 
		diffFrom: fileA 
		to: fileB.
	
	self assert: patch size equals: 5. 
	self 
		assert: (patch collect: #class as: Array)  
		equals: { DiffDelete. DiffInsert . DiffDelete. DiffDelete. DiffInsert }.
	self 
		assert: (patch collect: #oldPosition as: Array) 
		equals: {1. 2. 3. 6. 8}.
	self assert: (patch at: 2) newPosition equals: 1.
	self assert: (patch at: 5) newPosition equals: 6
]

{ #category : #tests }
DiffBuilderTest >> testDiffWithLines [
	| fileA fileB patch |
	
	fileA := 'test
with lines
that will change'.
	fileB := 'test
with LINES
that will change
'.
	
	patch := DiffBuilder new 
		diffFrom: fileA lines
		to: fileB lines.
	
	self assert: patch size equals: 5. 
	self 
		assert: (patch collect: #first as: Array)  
		equals: #('delete' 'insert' 'delete' 'delete' 'insert').
	self 
		assert: (patch collect: #second as: Array) 
		equals: {'old'->1. 'old'->2. 'old'->3. 'old'->6. 'old'->8}.
	self assert: (patch at: 2) third equals: 'new'->1.
	self assert: (patch at: 5) third equals: 'new'->6.
]
