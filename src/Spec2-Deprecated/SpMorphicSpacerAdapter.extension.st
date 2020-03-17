Extension { #name : #SpMorphicSpacerAdapter }

{ #category : #'*Spec2-Deprecated' }
SpMorphicSpacerAdapter >> buildWidget [
	^ Morph new
		color: Color transparent;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicSpacerAdapter class >> isDeprecated [
	^ true
]
