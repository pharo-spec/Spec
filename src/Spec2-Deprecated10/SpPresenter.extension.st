Extension { #name : #SpPresenter }

{ #category : #'*Spec2-Deprecated10' }
SpPresenter >> defaultSpec [
	self 
		deprecated: 'Please use #defaultLayout instead' 
		transformWith:  '`@receiver defaultSpec' 
						-> '`@receiver defaultLayout'.

	^ self class perform: self defaultSpecSelector
]
