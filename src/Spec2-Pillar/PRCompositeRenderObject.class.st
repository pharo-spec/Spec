Class {
	#name : #PRCompositeRenderObject,
	#superclass : #PRRenderObject,
	#instVars : [
		'children'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
PRCompositeRenderObject >> acceptRenderObjectVisitor: aVisitor [ 
	^ aVisitor visitCompositeObject: self
]

{ #category : #'as yet unclassified' }
PRCompositeRenderObject >> children [
	^ children
]

{ #category : #accessing }
PRCompositeRenderObject >> children: aCollection [ 
	children := aCollection
]
