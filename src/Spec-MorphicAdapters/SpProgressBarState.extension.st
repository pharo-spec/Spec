Extension { #name : #SpProgressBarState }

{ #category : #'*Spec-MorphicAdapters' }
SpProgressBarState >> customizeMorphicBar: aProgressBarMorph [
	self subclassResponsibility
]

{ #category : #'*Spec-MorphicAdapters' }
SpProgressBarState >> progressBarMorph [
	^ ProgressBarMorph
]
