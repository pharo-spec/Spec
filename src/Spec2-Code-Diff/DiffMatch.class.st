Class {
	#name : 'DiffMatch',
	#superclass : 'DiffPatchElement',
	#category : 'Spec2-Code-Diff',
	#package : 'Spec2-Code-Diff'
}

{ #category : 'instance creation' }
DiffMatch class >> newOldPosition: index element: element [

	^ (self newOldPosition: index) 
		element: element;
		yourself
]

{ #category : 'visiting' }
DiffMatch >> accept: aVisitor [

	aVisitor visitMatch: self
]

{ #category : 'testing' }
DiffMatch >> isMatch [

	^ true
]
