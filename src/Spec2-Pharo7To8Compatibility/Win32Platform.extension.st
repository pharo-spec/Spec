Extension { #name : 'Win32Platform' }

{ #category : '*Spec2-Pharo7To8Compatibility' }
Win32Platform >> accept: aVisitor [

	^ aVisitor visitWindows32: self
]
