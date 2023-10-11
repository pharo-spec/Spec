Class {
	#name : 'DiffReplyVisitor',
	#superclass : 'DiffVisitor',
	#instVars : [
		'stream'
	],
	#category : 'Spec2-Code-Diff',
	#package : 'Spec2-Code-Diff'
}

{ #category : 'accessing' }
DiffReplyVisitor >> contents [

	^ stream contents
]

{ #category : 'initialization' }
DiffReplyVisitor >> initialize [

	super initialize.
	stream := String new writeStream
]

{ #category : 'visiting' }
DiffReplyVisitor >> visitInsert: anInsert [

	stream << anInsert element << String cr
]

{ #category : 'visiting' }
DiffReplyVisitor >> visitMatch: aMatch [

	stream << aMatch element << String cr
]
