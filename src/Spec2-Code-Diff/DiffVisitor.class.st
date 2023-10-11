Class {
	#name : 'DiffVisitor',
	#superclass : 'Object',
	#category : 'Spec2-Code-Diff',
	#package : 'Spec2-Code-Diff'
}

{ #category : 'visiting' }
DiffVisitor >> visitDelete: anElement [
]

{ #category : 'visiting' }
DiffVisitor >> visitInsert: anElement [
]

{ #category : 'visiting' }
DiffVisitor >> visitMatch: anElement [
]

{ #category : 'visiting' }
DiffVisitor >> visitPatch: aPatch [

	aPatch elements 
		do: [ :each | each accept: self ]
]
