Extension { #name : #SpLabelledDropList }

{ #category : #'*Spec2-Deprecated' }
SpLabelledDropList >> displayBlock: aBlock [

	self
		deprecated: 'Please use #display: instead'
		transformWith: '`@receiver displayBlock: `@arg' 
						-> '`@receiver display: `@arg'.

	^self dropList display: aBlock
]
