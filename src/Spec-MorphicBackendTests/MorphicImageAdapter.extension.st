Extension { #name : #MorphicImageAdapter }

{ #category : #'*Spec-MorphicBackendTests' }
MorphicImageAdapter >> hasImageAutoscaled [
	^ self widget layout = #scaledAspect
]
