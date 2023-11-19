Class {
	#name : 'DiffPatch',
	#superclass : 'Object',
	#instVars : [
		'elements'
	],
	#category : 'Spec2-Code-Diff',
	#package : 'Spec2-Code-Diff'
}

{ #category : 'instance creation' }
DiffPatch class >> newElements: aCollection [

	^ self new elements: aCollection	
]

{ #category : 'visiting' }
DiffPatch >> accept: aVisitor [

	^ aVisitor visitPatch: self
]

{ #category : 'accessing' }
DiffPatch >> elements [

	^ elements
]

{ #category : 'accessing' }
DiffPatch >> elements: anObject [

	elements := anObject
]

{ #category : 'initialization' }
DiffPatch >> initialize [

	super initialize.
	elements := OrderedCollection new
]

{ #category : 'generating' }
DiffPatch >> patch [
	
	^ DiffPatchVisitor new
		visitPatch: self;
		contents
]

{ #category : 'generating' }
DiffPatch >> reply [
	
	^ DiffReplyVisitor new
		visitPatch: self;
		contents 
]
