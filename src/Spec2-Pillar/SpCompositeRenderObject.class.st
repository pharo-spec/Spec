Class {
	#name : #SpCompositeRenderObject,
	#superclass : #SpRenderObject,
	#instVars : [
		'children'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
SpCompositeRenderObject >> acceptRenderObjectVisitor: aVisitor [ 
	^ aVisitor visitCompositeObject: self
]

{ #category : #'as yet unclassified' }
SpCompositeRenderObject >> children [
	^ children
]

{ #category : #accessing }
SpCompositeRenderObject >> children: aCollection [ 
	children := aCollection
]
