Class {
	#name : #SpMorphicSpacerAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #factory }
SpMorphicSpacerAdapter >> buildWidget [
	^ Morph new
		color: Color transparent;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself
]
