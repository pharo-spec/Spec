Extension { #name : #SpMorphicCodeAdapter }

{ #category : #'*Spec2-Backend-Tests' }
SpMorphicCodeAdapter >> hasSyntaxHighlightEnabled [
	^ (self widget textArea editingMode isKindOf: RubPlainTextMode) not
]
