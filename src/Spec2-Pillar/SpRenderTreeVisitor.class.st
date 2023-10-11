Class {
	#name : 'SpRenderTreeVisitor',
	#superclass : 'Object',
	#category : 'Spec2-Pillar',
	#package : 'Spec2-Pillar'
}

{ #category : 'rendering' }
SpRenderTreeVisitor >> render: aRenderObject [

	^ aRenderObject acceptRenderObjectVisitor: self
]

{ #category : 'visiting' }
SpRenderTreeVisitor >> visit: aPRRenderObject [ 
	^ aPRRenderObject acceptRenderObjectVisitor: self 
]

{ #category : 'visiting' }
SpRenderTreeVisitor >> visitAll: aCollection [ 
	^ aCollection collect: [ :each | self visit: each ]
]

{ #category : 'visiting' }
SpRenderTreeVisitor >> visitCompositeObject: aPRCompositeRenderObject [ 
	^ self visitAll: aPRCompositeRenderObject children
]

{ #category : 'visiting' }
SpRenderTreeVisitor >> visitRenderObject: anItem [ 

]

{ #category : 'visiting' }
SpRenderTreeVisitor >> visitText: aText [
	^  self visitRenderObject: aText
]
