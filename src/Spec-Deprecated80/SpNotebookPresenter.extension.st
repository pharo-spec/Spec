Extension { #name : #SpNotebookPresenter }

{ #category : #'*Spec-Deprecated80' }
SpNotebookPresenter >> whenSelectedPageChanged: aBlock [
	self deprecated: 'Use #whenSelectedPageChangedDo: instead.' transformWith: '`@receiver whenSelectedPageChanged: `@statements' -> '`@receiver whenSelectedPageChangedDo: `@statements'.
	self whenSelectedPageChangedDo: aBlock
]
