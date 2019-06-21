Extension { #name : #SpProgressBarIndeterminated }

{ #category : #'*Spec-MorphicAdapters' }
SpProgressBarIndeterminated >> customizeMorphicBar: aProgressBarMorph [
	"Nothing to do here"
]

{ #category : #'*Spec-MorphicAdapters' }
SpProgressBarIndeterminated >> progressBarMorph [
	^ SpIndeterminatedProgressBarMorph
]
