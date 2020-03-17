Extension { #name : #SpLabelledList }

{ #category : #'*Spec2-Deprecated' }
SpLabelledList >> displayBlock: aBlock [

	self
		deprecated: 'Please use #display: instead'
		transformWith: '`@receiver displayBlock: `@arg' 
						-> '`@receiver display: `@arg'.

	^ self list display: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpLabelledList >> filteringBlock: aBlock [
	self
		deprecated: 'This feature is now removed from Spec 2. If the visible elements of the list need to be changed, it''s the users of the lists that should manage it and update the list of items of the list.'
]
