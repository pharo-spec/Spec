Extension { #name : #SpSearchableTree }

{ #category : #'*Spec2-Deprecated' }
SpSearchableTree >> displayBlock [

	self
		deprecated: 'Please use #display instead'
		transformWith: '`@receiver displayBlock' 
						-> '`@receiver display'.

	^ tree display
]

{ #category : #'*Spec2-Deprecated' }
SpSearchableTree >> displayBlock: aBlock [
	
	self
		deprecated: 'Please use #display: instead'
		transformWith: '`@receiver displayBlock: `@arg' 
						-> '`@receiver display: `@arg'.
	
	tree display: aBlock
]
