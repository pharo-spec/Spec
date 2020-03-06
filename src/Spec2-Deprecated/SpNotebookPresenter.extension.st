Extension { #name : #SpNotebookPresenter }

{ #category : #'*Spec2-Deprecated' }
SpNotebookPresenter >> selectedPage: aPage [

	self 
		deprecated: 'Use #selectPage: instead' 
		transformWith: '`@receiver selectedPage: `@statements1'
				-> '`@receiver selectPage: `@statements1'.
				
	self selectPage: aPage
]

{ #category : #'*Spec2-Deprecated' }
SpNotebookPresenter >> selectedPageIndex: aNumber [
	self 
		deprecated: 'Use #selectPageIndex: instead' 
		transformWith: '`@receiver selectedPageIndex: `@statements1'
				-> '`@receiver selectPageIndex: `@statements1'.
				
	self selectPageIndex: aNumber
]

{ #category : #'*Spec2-Deprecated' }
SpNotebookPresenter >> whenSelectedPageChanged: aBlock [
	self deprecated: 'Use #whenSelectedPageChangedDo: instead.' transformWith: '`@receiver whenSelectedPageChanged: `@statements' -> '`@receiver whenSelectedPageChangedDo: `@statements'.
	self whenSelectedPageChangedDo: aBlock
]
