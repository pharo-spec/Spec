Class {
	#name : 'DiffDelete',
	#superclass : 'DiffPatchElement',
	#category : 'Spec2-Code-Diff',
	#package : 'Spec2-Code-Diff'
}

{ #category : 'visiting' }
DiffDelete >> accept: aVisitor [

	aVisitor visitDelete: self
]

{ #category : 'testing' }
DiffDelete >> isDelete [

	^ true
]
