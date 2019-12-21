Extension { #name : #MacOSXPlatform }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
MacOSXPlatform >> accept: aVisitor [

	^ aVisitor visitMacOSX: self
]
