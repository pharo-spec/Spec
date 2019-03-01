Extension { #name : #ListPresenter }

{ #category : #'*Spec-Deprecated80' }
ListPresenter >> whenIconsChanged: aBlock [
	self deprecated: 'Use #whenIconsChangedDo: instead' transformWith: '`@receiver whenIconsChanged: `@argument' -> '`@receiver whenIconsChangedDo: `@argument'.
	self whenIconsChangedDo: aBlock
]
