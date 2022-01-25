Extension { #name : #SpFixedProgressBarState }

{ #category : #'*Spec2-Adapters-Morphic' }
SpFixedProgressBarState >> customizeMorphicBar: aProgressBarMorph [

	aProgressBarMorph value: self value
]

{ #category : #'*Spec2-Adapters-Morphic' }
SpFixedProgressBarState >> customizeMorphicLabel: aLabelMorph [

	aLabelMorph contents: (self value * 100) asInteger asString, '%'
]
