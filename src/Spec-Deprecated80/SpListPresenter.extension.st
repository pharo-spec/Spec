Extension { #name : #SpListPresenter }

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> allowToSelect [
	"Return whether the list items can be selected or not"
	
	self deprecated: 'Should not use. Use #selectionMode instead'.
	^ allowToSelect value
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> allowToSelect: aBoolean [
	"Set if the list items can be selected or not"

	self deprecated: 'Should not use. Use #selectionMode: instead'.
	allowToSelect value: aBoolean.
	aBoolean 
		ifFalse: [ self resetSelection ].
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> autoDeselect [
	"Return whether the list items can be selected if it's already the selected item"
	"If true, clicking again on the selected item will unselect it"

	self deprecated: 'Should not use. This feature is not supported anymore'.	
	^ autoDeselect value
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> autoDeselect: aBoolean [
	"Set if the list items can be selected again"

	self deprecated: 'Should not use. This feature is not supported anymore'.
	autoDeselect value: aBoolean
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> backgroundColorBlock [
	"Return the block use to compute the background color for each item"

	self deprecated: 'Should not use. This feature is not supported anymore. This feature depends on the theme'
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> backgroundColorBlock: aBlock [
	"Set the block used to compute an item background"

	self deprecated: 'Should not use. This feature is not supported anymore. This feature depends on the theme'
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> backgroundColorFor: anItem at: index [

	self deprecated: 'Should not use. This feature is not supported anymore. This feature depends on the theme'.
	^ self backgroundColorBlock cull: anItem cull: index
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> whenAllowToSelectChanged: aBlock [
	self deprecated: 'Use #whenAllowToSelectChangedDo: instead.' transformWith: '`@receiver whenAllowToSelectChanged: `@statements' -> '`@receiver whenAllowToSelectChangedDo: `@statements'.
	self whenAllowToSelectChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> whenAutoDeselectChanged: aBlock [
	self deprecated: 'Use #whenAutoDeselectChangedDo: instead.' transformWith: '`@receiver whenAutoDeselectChanged: `@statements' -> '`@receiver whenAutoDeselectChangedDo: `@statements'.
	self whenAutoDeselectChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> whenBackgroundColorBlockChanged: aBlock [

	self deprecated: 'Should not use. This feature is not supported anymore. This feature depends on the theme'.

]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> whenDisplayBlockChanged: aBlock [
	self deprecated: 'Use #whenDisplayBlockChangedDo: instead.' transformWith: '`@receiver whenDisplayBlockChanged: `@statements' -> '`@receiver whenDisplayBlockChangedDo: `@statements'.
	self whenDisplayBlockChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> whenFilteringBlockChanged: aBlock [
	self deprecated: 'Use #whenFilteringBlockChangedDo: instead.' transformWith: '`@receiver whenFilteringBlockChanged: `@statements' -> '`@receiver whenFilteringBlockChangedDo: `@statements'.
	self whenFilteringBlockChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> whenIconsChanged: aBlock [
	self deprecated: 'Use #whenIconsChangedDo: instead' transformWith: '`@receiver whenIconsChanged: `@argument' -> '`@receiver whenIconsChangedDo: `@argument'.
	self whenIconsChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> whenMenuChanged: aBlock [
	self deprecated: 'Use #whenMenuChangedDo: instead.' transformWith: '`@receiver whenMenuChanged: `@statements' -> '`@receiver whenMenuChangedDo: `@statements'.
	self whenMenuChangedDo: aBlock
]

{ #category : #'*Spec-Deprecated80' }
SpListPresenter >> whenSortingBlockChanged: aBlock [
	self deprecated: 'Use #whenSortingBlockChangedDo: instead.' transformWith: '`@receiver whenSortingBlockChanged: `@statements' -> '`@receiver whenSortingBlockChangedDo: `@statements'.
	self whenSortingBlockChangedDo: aBlock
]
