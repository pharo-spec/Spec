Extension { #name : #SpMorphicLayoutAdapter }

{ #category : #'*Spec2-Deprecated10' }
SpMorphicLayoutAdapter >> buildWithSpec [

	self 
		deprecated: 'Please use #build instead' 
		transformWith:  '`@receiver buildWithSpec' 
						-> '`@receiver build'. 
		
	^ self build
]

{ #category : #'*Spec2-Deprecated10' }
SpMorphicLayoutAdapter >> buildWithSpec: aString [

	self
		deprecated: 'Please use #buildWithLayout: instead'
		transformWith: '`@receiver buildWithSpec: `@arg'
			-> '`@receiver buildWithLayout: `@arg'.

	^ self buildWithLayout: aString
]
