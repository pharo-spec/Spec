"
I'm a spec adapter for a morph
"
Class {
	#name : #SpMorphicMorphAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'currentMorph'
	],
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #factory }
SpMorphicMorphAdapter >> buildWidget [

	currentMorph := self presenter morph 
		ifNil: [ Morph new color: Color transparent ].
	currentMorph presenter: self presenter.

	self presenter whenMorphChangedDo: [ :aMorph | 
		self updateMorph: aMorph ].
	
	^ currentMorph
]

{ #category : #factory }
SpMorphicMorphAdapter >> updateMorph: aMorph [

	self applyStyle: aMorph.
	aMorph presenter: self presenter.
	currentMorph owner ifNotNil: [ :ownerMorph | 
		ownerMorph 
			replaceSubmorph: currentMorph 
			by: aMorph ].
	currentMorph := aMorph
]
