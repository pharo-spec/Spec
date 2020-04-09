Class {
	#name : #PRRenderObject,
	#superclass : #Object,
	#instVars : [
		'item',
		'styles'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
PRRenderObject >> extraOffset [
	^ item plaintextOffset 
]

{ #category : #accessing }
PRRenderObject >> item [
	^ item
]

{ #category : #accessing }
PRRenderObject >> item: aDocumentItem [
	item := aDocumentItem 
]

{ #category : #accessing }
PRRenderObject >> node: aPRRenderTreeVisitor [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
PRRenderObject >> styles [
	^ styles
]

{ #category : #accessing }
PRRenderObject >> styles: aCollection [ 
	styles := aCollection
]
