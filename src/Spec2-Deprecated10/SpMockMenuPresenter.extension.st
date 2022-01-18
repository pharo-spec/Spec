Extension { #name : #SpMockMenuPresenter }

{ #category : #'*Spec2-Deprecated10' }
SpMockMenuPresenter >> buildWithSpec [

	self 
		deprecated: 'Please use #build instead' 
		transformWith:  '`@receiver buildWithSpec' 
						-> '`@receiver build'. 
	
	^ self build
]
