Class {
	#name : 'DiffPatchVisitor',
	#superclass : 'DiffVisitor',
	#instVars : [
		'stream'
	],
	#category : 'Spec2-Code-Diff',
	#package : 'Spec2-Code-Diff'
}

{ #category : 'accessing' }
DiffPatchVisitor >> contents [

	^ stream contents
]

{ #category : 'initialization' }
DiffPatchVisitor >> initialize [

	super initialize.
	stream := String new writeStream
]

{ #category : 'visiting' }
DiffPatchVisitor >> visitDelete: aDelete [

	stream << '-' << aDelete element << String cr
]

{ #category : 'visiting' }
DiffPatchVisitor >> visitInsert: anInsert [

	stream << '+' << anInsert element << String cr
]

{ #category : 'visiting' }
DiffPatchVisitor >> visitMatch: aMatch [

	stream << ' ' << aMatch element << String cr
]
