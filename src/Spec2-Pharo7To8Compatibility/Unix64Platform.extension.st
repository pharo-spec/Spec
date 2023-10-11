Extension { #name : 'Unix64Platform' }

{ #category : '*Spec2-Pharo7To8Compatibility' }
Unix64Platform >> accept: aVisitor [

	^ aVisitor visitUnix64: self
]
