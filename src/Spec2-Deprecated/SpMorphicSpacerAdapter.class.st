Class {
	#name : 'SpMorphicSpacerAdapter',
	#superclass : 'SpAbstractMorphicAdapter',
	#category : 'Spec2-Deprecated-Adapters',
	#package : 'Spec2-Deprecated',
	#tag : 'Adapters'
}

{ #category : '*Spec2-Deprecated' }
SpMorphicSpacerAdapter class >> isDeprecated [
	^ true
]

{ #category : '*Spec2-Deprecated' }
SpMorphicSpacerAdapter class >> isDeprecated [
	^ true
]

{ #category : '*Spec2-Deprecated' }
SpMorphicSpacerAdapter >> buildWidget [
	^ Morph new
		color: Color transparent;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself
]

{ #category : '*Spec2-Deprecated' }
SpMorphicSpacerAdapter >> buildWidget [
	^ Morph new
		color: Color transparent;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself
]
