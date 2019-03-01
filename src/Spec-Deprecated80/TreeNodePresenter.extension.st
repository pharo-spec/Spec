Extension { #name : #TreeNodePresenter }

{ #category : #'*Spec-Deprecated80' }
TreeNodePresenter >> whenContentChanged: aBlock [
	self deprecated: 'Use #whenContentChangedDo: instead.' transformWith: '`@receiver whenContentChanged: `@statements' -> '`@receiver whenContentChangedDo: `@statements'.
	self whenContentChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TreeNodePresenter >> whenIsExpandedChanged: aBlock [
	self deprecated: 'Use #whenIsExpandedChangedDo: instead.' transformWith: '`@receiver whenIsExpandedChanged: `@statements' -> '`@receiver whenIsExpandedChangedDo: `@statements'.
	self whenIsExpandedChangedDo: aBlock

	
]

{ #category : #'*Spec-Deprecated80' }
TreeNodePresenter >> whenSelectedChanged: aBlock [
	self deprecated: 'Use #whenSelectedChangedDo: instead.' transformWith: '`@receiver whenSelectedChanged: `@statements' -> '`@receiver whenSelectedChangedDo: `@statements'.
	self whenSelectedChangedDo: aBlock
]
