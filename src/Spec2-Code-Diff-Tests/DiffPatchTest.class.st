Class {
	#name : #DiffPatchTest,
	#superclass : #TestCase,
	#category : #'Spec2-Code-Diff-Tests'
}

{ #category : #'as yet unclassified' }
DiffPatchTest >> mockAST2 [

	^ 42 - 1
]

{ #category : #tests }
DiffPatchTest >> testPatch [
	| fileA fileB patch patchString |

	fileA := 'test
with lines
that will change
one time'.
	fileB := 'test
with Lines
that will change
	ONE time
	with indent?

'.

	patchString := ' test
-with lines
+with Lines
 that will change
-one time
+	ONE time
+	with indent?
+
'.

	patch := DiffBuilder
		buildPatchFrom: fileA lines 
		to: fileB lines.

	self assert: patch patch equals: patchString	

]

{ #category : #tests }
DiffPatchTest >> testReply [
	| fileA fileB patch |

	fileA := 'test
with lines
that will change
one time'.
	fileB := 'test
with Lines
that will change
	ONE time
	with indent?

'.

	patch := DiffBuilder
		buildPatchFrom: fileA lines 
		to: fileB lines.

	self assert: patch reply equals: fileB	

]
