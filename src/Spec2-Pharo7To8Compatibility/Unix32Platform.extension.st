Extension { #name : #Unix32Platform }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
Unix32Platform >> accept: aVisitor [

	^ aVisitor visitUnix32: self
]
