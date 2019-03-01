Extension { #name : #TextInputFieldPresenter }

{ #category : #'*Spec-Deprecated80' }
TextInputFieldPresenter >> beDecrypted [
	self
		deprecated: 'Use #beVisible instead'
		transformWith: '`@receiver beDecrypted' 
						-> '`@receiver beVisible'.
	
	self beVisible
]

{ #category : #'*Spec-Deprecated80' }
TextInputFieldPresenter >> beEncrypted [

	self
		deprecated: 'Use #beInvisible instead'
		transformWith: '`@receiver beEncrypted' 
						-> '`@receiver beInvisible'.
	
	self beInvisible
]

{ #category : #'*Spec-Deprecated80' }
TextInputFieldPresenter >> encrypted [

	self
		deprecated: 'Use #isVisible instead'
		transformWith: '`@receiver encrypted' 
						-> '`@receiver isVisible'.

	^ self isVisible not
]

{ #category : #'*Spec-Deprecated80' }
TextInputFieldPresenter >> encrypted: aBoolean [

	self
		deprecated: 'Use #beVisible: instead'
		transformWith: '`@receiver encrypted: `@arg' 
						-> '`@receiver beVisible: `@arg not'.

	self beVisible: aBoolean not.
]

{ #category : #'*Spec-Deprecated80' }
TextInputFieldPresenter >> ghostText [
	self deprecated: 'This API is too tight to Morph. Use #placeholder instead.' transformWith: '`@receiver ghostText' -> '`@receiver placeholder'.
	^ self placeholder
]

{ #category : #'*Spec-Deprecated80' }
TextInputFieldPresenter >> ghostText: aText [
	self deprecated: 'This API is too tight to Morph. Use #placeholder: instead.' transformWith: '`@receiver ghostText: `@statement' -> '`@receiver placeholder: `@statement'.
	self placeholder: aText
]

{ #category : #'*Spec-Deprecated80' }
TextInputFieldPresenter >> whenAcceptOnCRChanged: aBlock [
	self deprecated: 'Use #whenAcceptOnCRChangedDo: instead.' transformWith: '`@receiver whenAcceptOnCRChanged: `@statements' -> '`@receiver whenAcceptOnCRChangedDo: `@statements'.
	self whenAcceptOnCRChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextInputFieldPresenter >> whenEntryCompletionChanged: aBlock [
	self deprecated: 'Use #whenEntryCompletionChangedDo: instead.' transformWith: '`@receiver whenEntryCompletionChanged: `@statements' -> '`@receiver whenEntryCompletionChangedDo: `@statements'.
	self whenEntryCompletionChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextInputFieldPresenter >> whenGhostTextChanged: aBlock [
	self deprecated: 'This API is too tight to Morph. Use #whenPlaceholderChanged: instead.' transformWith: '`@receiver whenGhostTextChanged: `@statement' -> '`@receiver whenPlaceholderChanged: `@statement'.
	self whenPlaceholderChangedDo: aBlock
]
