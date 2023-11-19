Class {
	#name : 'DiffPatchElement',
	#superclass : 'Object',
	#instVars : [
		'oldPosition',
		'element'
	],
	#category : 'Spec2-Code-Diff',
	#package : 'Spec2-Code-Diff'
}

{ #category : 'instance creation' }
DiffPatchElement class >> newOldPosition: aNumber [

	^ self new oldPosition: aNumber 
]

{ #category : 'visiting' }
DiffPatchElement >> accept: aVisitor [

]

{ #category : 'accessing' }
DiffPatchElement >> element [

	^ element
]

{ #category : 'accessing' }
DiffPatchElement >> element: anObject [

	element := anObject
]

{ #category : 'testing' }
DiffPatchElement >> isDelete [

	^ false
]

{ #category : 'testing' }
DiffPatchElement >> isInsert [

	^ false
]

{ #category : 'testing' }
DiffPatchElement >> isMatch [

	^ false
]

{ #category : 'accessing' }
DiffPatchElement >> oldPosition [

	^ oldPosition
]

{ #category : 'accessing' }
DiffPatchElement >> oldPosition: anObject [

	oldPosition := anObject
]

{ #category : 'printing' }
DiffPatchElement >> printOn: stream [

	super printOn: stream.
	stream << '('.
	self printPositionOn: stream.
	stream << ')'
]

{ #category : 'printing' }
DiffPatchElement >> printPositionOn: stream [
	
	stream << 'old='; print: self oldPosition
]
