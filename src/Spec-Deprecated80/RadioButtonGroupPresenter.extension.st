Extension { #name : #RadioButtonGroupPresenter }

{ #category : #'*Spec-Deprecated80' }
RadioButtonGroupPresenter >> whenCanDeselectByClickChanged: aBlock [
	self deprecated: 'Use #whenCanDeselectByClickChangedDo: instead.' transformWith: '`@receiver whenCanDeselectByClickChanged: `@statements' -> '`@receiver whenCanDeselectByClickChangedDo: `@statements'.
	self whenCanDeselectByClickChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
RadioButtonGroupPresenter >> whenCurrentActivatedChanged: aBlock [
	self deprecated: 'Use #whenCurrentActivatedChangedDo: instead.' transformWith: '`@receiver whenCurrentActivatedChanged: `@statements' -> '`@receiver whenCurrentActivatedChangedDo: `@statements'.
	self whenCurrentActivatedChangedDo: aBlock
]
