Extension { #name : #SpMorphicTextInputFieldAdapter }

{ #category : #'*Spec-Deprecated80' }
SpMorphicTextInputFieldAdapter >> ghostText [
	self deprecated: 'This API is too tight to Morph. Use #placeholder instead.' transformWith: '`@receiver ghostText' -> '`@receiver placeholder'.
	^ self placeholder
]

{ #category : #'*Spec-Deprecated80' }
SpMorphicTextInputFieldAdapter >> ghostText: aText [
	self deprecated: 'This API is too tight to Morph. Use #placeholder: instead.' transformWith: '`@receiver ghostText: `@statement' -> '`@receiver placeholder: `@statement'.
	self placeholder: aText
]
