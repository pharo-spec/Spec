Class {
	#name : #SpRenderObject,
	#superclass : #Object,
	#instVars : [
		'item',
		'styles'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #accessing }
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

{ #category : #accessing }
SpRenderObject >> styles [
	^ styles
]

{ #category : #accessing }
SpRenderObject >> styles: aCollection [ 
	styles := aCollection
]
