Extension { #name : #WindowPresenter }

{ #category : #'*Spec-Deprecated80' }
WindowPresenter >> addModelIn: widgetToBuild withSpecLayout: aSpec [
	self
		deprecated: 'Use #addPresenterIn:withSpecLayout: instead.'
		transformWith: '`@receiver addModelIn: `@statements1 withSpecLayout: `@statements2' -> '`@receiver addPresenterIn: `@statements1 withSpecLayout: `@statements2'.
	self addPresenterIn: widgetToBuild withSpecLayout: aSpec
]

{ #category : #'*Spec-Deprecated80' }
WindowPresenter >> model [
	self deprecated: 'Model was renamed Presenter in Pharo 7' transformWith: '`@receiver model' -> '`@receiver presenter'.
	
	^ self presenter
]

{ #category : #'*Spec-Deprecated80' }
WindowPresenter >> model: aModel [
	self deprecated: 'Model was renamed Presenter in Pharo 7' transformWith: '`@receiver model: `@statements1' -> '`@receiver presenter: `@statements1'.

	self presenter: aModel
]
