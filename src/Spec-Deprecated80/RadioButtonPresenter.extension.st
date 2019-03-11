Extension { #name : #RadioButtonPresenter }

{ #category : #'*Spec-Deprecated80' }
RadioButtonPresenter >> whenCanDeselectByClickChanged: aBlock [
	self deprecated: 'Use #whenCanDeselectByClickChangedDo: instead.' transformWith: '`@receiver whenCanDeselectByClickChanged: `@statements' -> '`@receiver whenCanDeselectByClickChangedDo: `@statements'.
	self whenCanDeselectByClickChangedDo: aBlock
]
