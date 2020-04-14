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

{ #category : #adding }
SpCompositeRenderObject >> add: aDocumentItem [
	children add: aDocumentItem 
]

{ #category : #'as yet unclassified' }
SpCompositeRenderObject >> children [
	^ children
]

{ #category : #accessing }
SpCompositeRenderObject >> children: aCollection [ 
	children := aCollection
]

{ #category : #initialization }
SpCompositeRenderObject >> initialize [
	super initialize.
	children := OrderedCollection new
]
