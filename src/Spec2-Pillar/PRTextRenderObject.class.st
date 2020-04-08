Class {
	#name : #PRTextRenderObject,
	#superclass : #PRRenderObject,
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
PRTextRenderObject >> acceptRenderObjectVisitor: aVisitor [ 
	^ aVisitor visitText: self
]

{ #category : #'as yet unclassified' }
PRTextRenderObject >> contents [
	^ item text 
]

{ #category : #printing }
PRTextRenderObject >> printOn: aStream [
	aStream << 'text object: ' << self contents
]
