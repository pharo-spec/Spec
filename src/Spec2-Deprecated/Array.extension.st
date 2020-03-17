Extension { #name : #Array }

{ #category : #'*Spec2-Deprecated' }
Array >> asSpLayout [
	^ SpLegacyArrayLayout new
		array: self;
		yourself
]
