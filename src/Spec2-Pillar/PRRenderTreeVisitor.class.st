Class {
	#name : #PRRenderTreeVisitor,
	#superclass : #Object,
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
PRRenderTreeVisitor >> render: aRenderObject [

	^ aRenderObject acceptRenderObjectVisitor: self
]

{ #category : #'as yet unclassified' }
PRRenderTreeVisitor >> visit: aPRRenderObject [ 
	^ aPRRenderObject acceptRenderObjectVisitor: self 
]

{ #category : #'as yet unclassified' }
PRRenderTreeVisitor >> visitAll: aCollection [ 
	^ aCollection collect: [ :each | self visit: each ]
]

{ #category : #'as yet unclassified' }
PRRenderTreeVisitor >> visitCompositeObject: aPRCompositeRenderObject [ 
	^ (self visitAll: aPRCompositeRenderObject children) "select: [ :each | each isKindOf: PRRenderObject  ]"
]

{ #category : #'as yet unclassified' }
PRRenderTreeVisitor >> visitRenderObject: anItem [ 

]

{ #category : #visiting }
PRRenderTreeVisitor >> visitText: aText [
	^  self visitRenderObject: aText
]
