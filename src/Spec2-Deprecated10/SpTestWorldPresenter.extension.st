Extension { #name : #SpTestWorldPresenter }

{ #category : #'*Spec2-Deprecated10' }
SpTestWorldPresenter >> openWithSpecLayout: aSpecLayout [

	self 
		deprecated: 'Please use #openWithLayout: instead' 
		transformWith:  '`@receiver openWithSpecLayout: `@arg' 
						-> '`@receiver openWithLayout: `@arg'. 

	self openWithLayout: aSpecLayout
]
