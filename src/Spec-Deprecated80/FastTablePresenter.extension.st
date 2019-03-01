Extension { #name : #FastTablePresenter }

{ #category : #'*Spec-Deprecated80' }
FastTablePresenter >> whenIconsChanged: aBlock [
	self deprecated: 'Use #whenIconsChangedDo: instead.' transformWith: '`@receiver whenIconsChanged: `@statements' -> '`@receiver whenIconsChangedDo: `@statements'.
	self whenIconsChangedDo: aBlock
]
