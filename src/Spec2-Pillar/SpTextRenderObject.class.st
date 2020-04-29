Class {
	#name : #SpTextRenderObject,
	#superclass : #SpRenderObject,
	#category : #'Spec2-Pillar'
}

{ #category : #visiting }
SpTextRenderObject >> acceptRenderObjectVisitor: aVisitor [ 
	^ aVisitor visitText: self
]

{ #category : #accessing }
SpTextRenderObject >> contents [
	^ item text 
]

{ #category : #printing }
SpTextRenderObject >> printOn: aStream [
	aStream << 'text object: ' << self contents
]
