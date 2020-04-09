Class {
	#name : #SpRenderTreeVisitor,
	#superclass : #Object,
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
SpRenderTreeVisitor >> render: aRenderObject [

	^ aRenderObject acceptRenderObjectVisitor: self
]

{ #category : #'as yet unclassified' }
SpRenderTreeVisitor >> visit: aPRRenderObject [ 
	^ aPRRenderObject acceptRenderObjectVisitor: self 
]

{ #category : #'as yet unclassified' }
SpRenderTreeVisitor >> visitAll: aCollection [ 
	^ aCollection collect: [ :each | self visit: each ]
]

{ #category : #'as yet unclassified' }
SpRenderTreeVisitor >> visitCompositeObject: aPRCompositeRenderObject [ 
	^ self visitAll: aPRCompositeRenderObject children
]

{ #category : #'as yet unclassified' }
SpRenderTreeVisitor >> visitRenderObject: anItem [ 

]

{ #category : #visiting }
SpRenderTreeVisitor >> visitText: aText [
	^  self visitRenderObject: aText
]
