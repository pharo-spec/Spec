Class {
	#name : #SpRenderObject,
	#superclass : #Object,
	#instVars : [
		'item',
		'styles'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
SpRenderObject >> extraOffset [
	^ item plaintextOffset 
]

{ #category : #accessing }
SpRenderObject >> item [
	^ item
]

{ #category : #accessing }
SpRenderObject >> item: aDocumentItem [
	item := aDocumentItem 
]

{ #category : #accessing }
SpRenderObject >> node: aPRRenderTreeVisitor [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
SpRenderObject >> styles [
	^ styles
]

{ #category : #accessing }
SpRenderObject >> styles: aCollection [ 
	styles := aCollection
]
