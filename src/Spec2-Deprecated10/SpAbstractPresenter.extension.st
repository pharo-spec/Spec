Extension { #name : #SpAbstractPresenter }

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> openModalWithSpec [

	self 
		deprecated: 'Please use #openModal instead' 
		transformWith:  '`@receiver openModalWithSpec' 
						-> '`@receiver openModal'. 
						
	^ self openModal
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> openModalWithSpec: aSpecLayout [

	self
		deprecated: 'Please use #openModalWithLayout: instead' 
		transformWith:  '`@receiver openModalWithSpec: `@arg' 
						-> '`@receiver openModalWithLayout: `@arg'.

	^ self openModalWithLayout: aSpecLayout
]
