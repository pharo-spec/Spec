Extension { #name : 'Win64Platform' }

{ #category : '*Spec2-Pharo7To8Compatibility' }
Win64Platform >> accept: aVisitor [

	^ aVisitor visitWindows64: self
]
