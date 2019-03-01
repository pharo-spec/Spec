Extension { #name : #TextPresenter }

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenAboutToStyleBlockChanged: aBlock [
	self deprecated: 'Use #whenAboutToStyleBlockChangedDo: instead.' transformWith: '`@receiver whenAboutToStyleBlockChanged: `@statements' -> '`@receiver whenAboutToStyleBlockChangedDo: `@statements'.
	self whenAboutToStyleBlockChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenAboutToStyleChanged: aBlock [
	self deprecated: 'Use #whenAboutToStyleChangedDo: instead.' transformWith: '`@receiver whenAboutToStyleChanged: `@statements' -> '`@receiver whenAboutToStyleChangedDo: `@statements'.
	self whenAboutToStyleChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenAcceptBlockChanged: aBlock [
	self deprecated: 'Use #whenAcceptBlockChangedDo: instead.' transformWith: '`@receiver whenAcceptBlockChanged: `@statements' -> '`@receiver whenAcceptBlockChangedDo: `@statements'.
	self whenAcceptBlockChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenAutoAcceptChanged: aBlock [
	self deprecated: 'Use #whenAutoAcceptChangedDo: instead.' transformWith: '`@receiver whenAutoAcceptChanged: `@statements' -> '`@receiver whenAutoAcceptChangedDo: `@statements'.
	self whenAutoAcceptChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenBehaviorChanged: aBlock [
	self deprecated: 'Use #whenBehaviorChangedDo: instead.' transformWith: '`@receiver whenBehaviorChanged: `@statements' -> '`@receiver whenBehaviorChangedDo: `@statements'.
	self whenBehaviorChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenCodeCompletionAllowedChanged: aBlock [
	self deprecated: 'Use #whenCodeCompletionAllowedChangedDo: instead.' transformWith: '`@receiver whenCodeCompletionAllowedChanged: `@statements' -> '`@receiver whenCodeCompletionAllowedChangedDo: `@statements'.
	self whenCodeCompletionAllowedChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenMenuHolderChanged: aBlock [
	self deprecated: 'Use #whenMenuHolderChangedDo: instead.' transformWith: '`@receiver whenMenuHolderChanged: `@statements' -> '`@receiver whenMenuHolderChangedDo: `@statements'.
	self whenMenuHolderChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenReadSelectionIsChanged: aBlock [
	self deprecated: 'Use #whenReadSelectionIsChangedDo: instead.' transformWith: '`@receiver whenReadSelectionIsChanged: `@statements' -> '`@receiver whenReadSelectionIsChangedDo: `@statements'.
	self whenReadSelectionIsChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenScrollValueChanged: aBlock [
	self deprecated: 'Use #whenScrollValueChangedDo: instead.' transformWith: '`@receiver whenScrollValueChanged: `@statements' -> '`@receiver whenScrollValueChangedDo: `@statements'.
	self whenScrollValueChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenTextChanged: aBlock [
	self deprecated: 'Use #whenTextChangedDo: instead.' transformWith: '`@receiver whenTextChanged: `@statement' -> '`@receiver whenTextChangedDo: `@statement'.
	self whenTextChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TextPresenter >> whenTextIsAccepted: aBlock [
	self deprecated: 'Use #whenTextIsAcceptedDo: instead.' transformWith: '`@receiver whenTextIsAccepted: `@statements' -> '`@receiver whenTextIsAcceptedDo: `@statements'.
	self whenTextIsAcceptedDo: aBlock
]
