Class {
	#name : #SpMorphicPatchLineVisitor,
	#superclass : #DiffVisitor,
	#instVars : [
		'lineNumber',
		'stream',
		'lineMarks'
	],
	#category : #'Spec2-Code-Diff-Morphic'
}

{ #category : #accessing }
SpMorphicPatchLineVisitor >> contents [

	^ stream contents
]

{ #category : #initialization }
SpMorphicPatchLineVisitor >> initialize [

	super initialize.
	lineNumber := 0.
	lineMarks := OrderedCollection new.
	stream := String new writeStream
]

{ #category : #accessing }
SpMorphicPatchLineVisitor >> lineMarks [

	^ lineMarks
]

{ #category : #visiting }
SpMorphicPatchLineVisitor >> visitDelete: aPatchElement [

	lineNumber := lineNumber + 1.
	lineMarks add: lineNumber -> #delete.
	stream << aPatchElement element << String cr
]

{ #category : #visiting }
SpMorphicPatchLineVisitor >> visitInsert: aPatchElement [

	lineNumber := lineNumber + 1.
	lineMarks add: lineNumber -> #insert.
	stream << aPatchElement element << String cr
]

{ #category : #visiting }
SpMorphicPatchLineVisitor >> visitMatch: aPatchElement [

	lineNumber := lineNumber + 1.
	stream << aPatchElement element << String cr
]
