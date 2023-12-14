Class {
	#name : 'DiffBuilderTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Code-Diff-Tests',
	#package : 'Spec2-Code-Diff-Tests'
}

{ #category : 'tests' }
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

{ #category : 'tests' }
DiffBuilderTest >> testDiffIRecordsLastLineWhenMatching [
	| patch fileA fileB |

	fileA := 'newSourceView
			
	^ GtkSourceView new
		beWrapWord;
		showLineNumbers: true;
		autoIndent: true;
		yourself'.

	fileB := 'newSourceView

	^ GtkSourceView new
		beWrapWord;
		monospace: true;
		showLineNumbers: "self presenter hasLineNumbers" false;
		showLineMarks: true;
		autoIndent: true;
		indentOnTab: true;
		tabWidth: 4;
		yourself'.

	patch := DiffBuilder 
		buildPatchFrom: fileA lines
		to: fileB lines.
	
	self assert: patch elements last element equals: '		yourself'
]

{ #category : 'tests' }
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
	
	self assert: patch size equals: 2. 
	self 
		assert: (patch collect: #class) 
		equals: { DiffDelete. DiffInsert }.
	self assert: (patch collect: #oldPosition as: Array) equals: #(2 3).
	self assert: (patch at: 2) newPosition equals: 2
]

{ #category : 'tests' }
DiffBuilderTest >> testDiffWithLinesRecordsDelete [
	| fileA fileB patch |
	
	fileA := 'a
b
c'.
	fileB := 'a
b
d'.
	
	patch := DiffBuilder new 
		diffFrom: fileA lines
		to: fileB lines.
	
	self assert: patch size equals: 2. 
	self 
		assert: (patch collect: #class) 
		equals: { DiffDelete. DiffInsert }.
	self assert: (patch collect: #oldPosition as: Array) equals: #(3 4).
	self assert: (patch at: 2) newPosition equals: 3
]
