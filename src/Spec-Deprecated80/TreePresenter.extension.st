Extension { #name : #TreePresenter }

{ #category : #'*Spec-Deprecated80' }
TreePresenter >> whenChildrenBlockChanged: aBlock [
	self deprecated: 'Use #whenChildrenBlockChangedDo: instead.' transformWith: '`@receiver whenChildrenBlockChanged: `@statements' -> '`@receiver whenChildrenBlockChangedDo: `@statements'.
	self whenChildrenBlockChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TreePresenter >> whenDisplayBlockChanged: aBlock [
	self deprecated: 'Use #whenDisplayBlockChangedDo: instead.' transformWith: '`@receiver whenDisplayBlockChanged: `@statements' -> '`@receiver whenDisplayBlockChangedDo: `@statements'.
	self whenDisplayBlockChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TreePresenter >> whenHasChildrenBlockChanged: aBlock [
	self deprecated: 'Use #whenHasChildrenBlockChangedDo: instead.' transformWith: '`@receiver whenHasChildrenBlockChanged: `@statements' -> '`@receiver whenHasChildrenBlockChangedDo: `@statements'.
	self whenHasChildrenBlockChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TreePresenter >> whenHighlightedItemChanged: aBlock [
	self deprecated: 'Use #whenHighlightedItemChangedDo: instead.' transformWith: '`@receiver whenHighlightedItemChanged: `@statements' -> '`@receiver whenHighlightedItemChangedDo: `@statements'.
	self whenHighlightedItemChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TreePresenter >> whenMenuChanged: aBlock [
	self deprecated: 'Use #whenMenuChangedDo: instead.' transformWith: '`@receiver whenMenuChanged: `@statements' -> '`@receiver whenMenuChangedDo: `@statements'.
	self whenMenuChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TreePresenter >> whenRootsChanged: aBlock [
	self deprecated: 'Use #whenRootsChangedDo: instead.' transformWith: '`@receiver whenRootsChanged: `@statements' -> '`@receiver whenRootsChangedDo: `@statements'.
	self whenRootsChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TreePresenter >> whenSelectedItemChanged: aBlock [
	self deprecated: 'Use #whenSelectedItemChangedDo: instead.' transformWith: '`@receiver whenSelectedItemChanged: `@statements' -> '`@receiver whenSelectedItemChangedDo: `@statements'.
	self whenSelectedItemChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TreePresenter >> whenSelectedItemsChanged: aBlock [
	self deprecated: 'Use #whenSelectedItemsChangedDo: instead.' transformWith: '`@receiver whenSelectedItemsChanged: `@statements' -> '`@receiver whenSelectedItemsChangedDo: `@statements'.
	self whenSelectedItemsChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
TreePresenter >> whenTreeUpdated: aBlock [
	self deprecated: 'Use #whenTreeUpdatedDo: instead.' transformWith: '`@receiver whenTreeUpdated: `@statements' -> '`@receiver whenTreeUpdatedDo: `@statements'.
	self whenTreeUpdatedDo: aBlock
]
