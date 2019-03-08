Extension { #name : #MorphicWindowAdapter }

{ #category : #'*Spec-Deprecated80' }
MorphicWindowAdapter >> addModelIn: widgetToBuild withSpecLayout: aSpec [
	self
		deprecated: 'Use #addPresenterIn:withSpecLayout: instead.'
		transformWith: '`@receiver addModelIn: `@statements1 withSpecLayout: `@statements2' -> '`@receiver addPresenterIn: `@statements1 withSpecLayout: `@statements2'.
	self addPresenterIn: widgetToBuild withSpecLayout: aSpec
]
