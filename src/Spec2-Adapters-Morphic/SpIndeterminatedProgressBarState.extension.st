Extension { #name : #SpIndeterminatedProgressBarState }

{ #category : #'*Spec2-Adapters-Morphic' }
SpIndeterminatedProgressBarState >> customizeMorphicBar: aProgressBarMorph [
	"Nothing to do here"
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpIndeterminatedProgressBarState >> customizeMorphicLabel: aLabelMorph [

	aLabelMorph contents: 'Processing...'
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpIndeterminatedProgressBarState >> progressBarMorph [
	^ SpIndeterminatedProgressBarMorph
]
