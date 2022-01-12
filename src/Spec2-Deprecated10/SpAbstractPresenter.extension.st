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
