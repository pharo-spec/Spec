Extension { #name : #ProgressBarFixed }

{ #category : #'*Spec-MorphicAdapters' }
ProgressBarFixed >> customizeMorphicBar: aProgressBarMorph [
	self value logCr.
	aProgressBarMorph value: self value
]
