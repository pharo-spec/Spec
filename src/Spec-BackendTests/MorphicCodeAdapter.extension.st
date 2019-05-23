Extension { #name : #MorphicCodeAdapter }

{ #category : #'*Spec-BackendTests' }
MorphicCodeAdapter >> hasSyntaxHighlightEnabled [
	^ self widget shoutStyler isNotNil
]
