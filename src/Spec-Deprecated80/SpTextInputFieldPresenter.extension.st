Extension { #name : #SpTextInputFieldPresenter }

{ #category : #'*Spec-Deprecated80' }
SpTextInputFieldPresenter >> beDecrypted [
	self deprecated: 'Use #beText instead' transformWith: '`@receiver beDecrypted' -> '`@receiver beText'.
	self beText
]

{ #category : #'*Spec-Deprecated80' }
SpTextInputFieldPresenter >> beEncrypted [
	self deprecated: 'Use #bePassword instead' transformWith: '`@receiver beEncrypted' -> '`@receiver bePassword'.

	self bePassword
]

{ #category : #'*Spec-Deprecated80' }
SpTextInputFieldPresenter >> encrypted [
	self deprecated: 'Use #isPassword instead' transformWith: '`@receiver encrypted' -> '`@receiver isPassword'.
	^ self isPassword
]

{ #category : #'*Spec-Deprecated80' }
SpTextInputFieldPresenter >> encrypted: aBoolean [
	self deprecated: 'Use #bePassword: instead' transformWith: '`@receiver encrypted: `@arg' -> '`@receiver bePassword: `@arg'.
	self bePassword: aBoolean
]

{ #category : #'*Spec-Deprecated80' }
SpTextInputFieldPresenter >> ghostText [
	self deprecated: 'This API is too tight to Morph. Use #placeholder instead.' transformWith: '`@receiver ghostText' -> '`@receiver placeholder'.
	^ self placeholder
]

{ #category : #'*Spec-Deprecated80' }
SpTextInputFieldPresenter >> ghostText: aText [
	self deprecated: 'This API is too tight to Morph. Use #placeholder: instead.' transformWith: '`@receiver ghostText: `@statement' -> '`@receiver placeholder: `@statement'.
	self placeholder: aText
]

{ #category : #'*Spec-Deprecated80' }
SpTextInputFieldPresenter >> whenAcceptOnCRChanged: aBlock [
	self deprecated: 'Use #whenAcceptOnCRChangedDo: instead.' transformWith: '`@receiver whenAcceptOnCRChanged: `@statements' -> '`@receiver whenAcceptOnCRChangedDo: `@statements'.
	self whenAcceptOnCRChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
SpTextInputFieldPresenter >> whenEntryCompletionChanged: aBlock [
	self deprecated: 'Use #whenEntryCompletionChangedDo: instead.' transformWith: '`@receiver whenEntryCompletionChanged: `@statements' -> '`@receiver whenEntryCompletionChangedDo: `@statements'.
	self whenEntryCompletionChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
SpTextInputFieldPresenter >> whenGhostTextChanged: aBlock [
	self deprecated: 'This API is too tight to Morph. Use #whenPlaceholderChanged: instead.' transformWith: '`@receiver whenGhostTextChanged: `@statement' -> '`@receiver whenPlaceholderChanged: `@statement'.
	self whenPlaceholderChangedDo: aBlock
]
