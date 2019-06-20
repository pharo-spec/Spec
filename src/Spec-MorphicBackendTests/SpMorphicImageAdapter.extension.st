Extension { #name : #SpMorphicImageAdapter }

{ #category : #'*Spec-MorphicBackendTests' }
SpMorphicImageAdapter >> hasImageAutoscaled [
	^ self widget layout = #scaledAspect
]
