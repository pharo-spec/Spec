Extension { #name : #SpMorphicCodeAdapter }

{ #category : #'*Spec-Deprecated80' }
SpMorphicCodeAdapter >> isAboutToStyle [
	self deprecated: 'Use #okToStle instead' transformWith: '`@receiver isAboutToStyle' -> '`@receiver okToStyle'.
	^ self okToStyle
]
