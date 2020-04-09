Class {
	#name : #SpTextRenderObject,
	#superclass : #SpRenderObject,
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
SpTextRenderObject >> acceptRenderObjectVisitor: aVisitor [ 
	^ aVisitor visitText: self
]

{ #category : #'as yet unclassified' }
SpTextRenderObject >> contents [
	^ item text 
]

{ #category : #printing }
SpTextRenderObject >> printOn: aStream [
	aStream << 'text object: ' << self contents
]
