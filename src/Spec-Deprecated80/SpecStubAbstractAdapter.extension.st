Extension { #name : #SpecStubAbstractAdapter }

{ #category : #'*Spec-Deprecated80' }
SpecStubAbstractAdapter >> addModelIn: widgetToBuild withSpecLayout: aSpec [
	self
		deprecated: 'Use #addPresenterIn:withSpecLayout: instead.'
		transformWith: '`@receiver addModelIn: `@statements1 withSpecLayout: `@statements2' -> '`@receiver addPresenterIn: `@statements1 withSpecLayout: `@statements2'.
	self addPresenterIn: widgetToBuild withSpecLayout: aSpec
]
