Extension { #name : #SpDialogPresenter }

{ #category : #'*Spec2-Deprecated10' }
SpDialogPresenter >> openDialogWithSpecParent: aWindow [
	self 
		deprecated: 'Please use #openDialogWithParent: instead' 
		transformWith:  '`@receiver openDialogWithSpecParent: `@arg' 
						-> '`@receiver openDialogWithParent: `@arg'. 
						
	^ self openDialogWithParent: aWindow
]
