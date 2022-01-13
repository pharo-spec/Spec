Extension { #name : #SpAbstractPresenter }

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> buildWithSpec [
	"Build the widget using the default layout"

	self 
		deprecated: 'Please use #build instead' 
		transformWith:  '`@receiver buildWithSpec' 
						-> '`@receiver build'. 
	
	^ self build
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> buildWithSpec: aSelectorOrLayout [

	"Build the widget using the layout selector provided as argument"

	^ aSelectorOrLayout isSpLayout 
		ifTrue: [ self 
						deprecated: 'Please use #buildWithLayout: instead' 
						transformWith:  '`@receiver buildWithSpec: `@arg' 
											-> '`@receiver buildWithLayout: `@arg'.
					self buildWithLayout: aSelectorOrLayout ]
		ifFalse: [ self 
						deprecated: 'Please use #buildWithSelector: instead' 
						transformWith:  '`@receiver buildWithSpec: `@arg' 
											-> '`@receiver buildWithSelector: `@arg'.
					self buildWithSelector: aSelectorOrLayout ]
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> buildWithSpecLayout: aSpecLayout [
	"Build the widget using the layout provided as argument"

	self 
		deprecated: 'Please use #buildWithLayout: instead' 
		transformWith:  '`@receiver buildWithSpecLayout: `@arg' 
						-> '`@receiver buildWithLayout: `@arg'. 

	^ self buildWithLayout: aSpecLayout
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> openBlockedDialogWithSpec [
	self 
		deprecated: 'Please use #openBlockedDialog instead' 
		transformWith:  '`@receiver openBlockedDialogWithSpec' 
						-> '`@receiver openBlockedDialog'.
						
	^ self openBlockedDialog
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> openBlockedDialogWithSpec: aSelector [
	self deprecated: 'Please use #openBlockedDialogWithLayout: instead. You should provide a valid instance of a layout and not a selector name'.
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> openDialogWithSpec [
	self 
		deprecated: 'Please use #openDialog instead' 
		transformWith:  '`@receiver openDialogWithSpec' 
						-> '`@receiver openDialog'.
						
	^ self openDialog
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> openDialogWithSpec: aSpecLayout [
	self 
		deprecated: 'Please use #openDialogWithLayout: instead' 
		transformWith:  '`@receiver openDialogWithSpec: `@arg' 
						-> '`@receiver openDialogWithLayout: `@arg'. 
						
	^ self openDialogWithLayout: aSpecLayout
]

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

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> openWithSpec [

	self 
		deprecated: 'Please use #open instead' 
		transformWith:  '`@receiver openWithSpec' 
						-> '`@receiver open'. 

	^ self open
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> openWithSpec: aSpecLayout [

	self 
		deprecated: 'Please use #openWithLayout: instead' 
		transformWith:  '`@receiver openWithSpec: `@arg' 
						-> '`@receiver openWithLayout: `@arg'. 
						
	^ self openWithLayout: aSpecLayout
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> openWithSpecLayout: aSpecLayout [

	self 
		deprecated: 'Please use #openWithLayout: instead' 
		transformWith:  '`@receiver openWithSpecLayout: `@arg' 
						-> '`@receiver openWithLayout: `@arg'. 
						
	^ self openWithLayout: aSpecLayout
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> retrieveSpec: aSelector [

	self 
		deprecated: 'Please use #retrieveLayout: instead' 
		transformWith:  '`@receiver retrieveSpec: `@arg' 
						-> '`@receiver retrieveLayout: `@arg'. 

	^ self retrieveLayout: aSelector
]

{ #category : #'*Spec2-Deprecated10' }
SpAbstractPresenter >> spec [
	self 
		deprecated: 'Please use #adapter instead' 
		transformWith:  '`@receiver spec' 
						-> '`@receiver adapter'. 
						
	^ self adapter
]
