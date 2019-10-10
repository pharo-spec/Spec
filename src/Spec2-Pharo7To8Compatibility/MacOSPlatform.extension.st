Extension { #name : #MacOSPlatform }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
MacOSPlatform >> accept: aVisitor [

	^ aVisitor visitMacOS: self
]
