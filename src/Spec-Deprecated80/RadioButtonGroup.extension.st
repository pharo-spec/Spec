Extension { #name : #RadioButtonGroup }

{ #category : #'*Spec-Deprecated80' }
RadioButtonGroup >> whenCanDeselectByClickChanged: aBlock [
	self deprecated: 'Use #whenCanDeselectByClickChangedDo: instead.' transformWith: '`@receiver whenCanDeselectByClickChanged: `@statements' -> '`@receiver whenCanDeselectByClickChangedDo: `@statements'.
	self whenCanDeselectByClickChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
RadioButtonGroup >> whenCurrentlyActivatedChanged: aBlock [
	self deprecated: 'Use #whenCurrentlyActivatedChangedDo: instead.' transformWith: '`@receiver whenCurrentlyActivatedChanged: `@statements' -> '`@receiver whenCurrentlyActivatedChangedDo: `@statements'.
	self whenCurrentlyActivatedChangedDo: aBlock
]
