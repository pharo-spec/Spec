Extension { #name : #UnixPlatform }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
UnixPlatform >> accept: aVisitor [

	^ aVisitor visitUnix: self
]
