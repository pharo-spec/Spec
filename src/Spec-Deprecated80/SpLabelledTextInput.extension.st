Extension { #name : #SpLabelledTextInput }

{ #category : #'*Spec-Deprecated80' }
SpLabelledTextInput >> ghostText: aText [
	self deprecated: 'This API is too tight to Morph. Use #placeholder: instead.' transformWith: '`@receiver ghostText: `@statement' -> '`@receiver placeholder: `@statement'.
	self placeholder: aText
]
