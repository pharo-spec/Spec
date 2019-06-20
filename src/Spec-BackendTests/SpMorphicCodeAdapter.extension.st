Extension { #name : #SpMorphicCodeAdapter }

{ #category : #'*Spec-BackendTests' }
SpMorphicCodeAdapter >> hasSyntaxHighlightEnabled [
	^ (self widget textArea editingMode isKindOf: RubPlainTextMode) not
]
