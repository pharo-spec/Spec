Extension { #name : #WinPlatform }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
WinPlatform >> accept: aVisitor [

	^ aVisitor visitWindows: self
]
