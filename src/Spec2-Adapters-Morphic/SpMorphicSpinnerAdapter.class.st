"
I'm the adapter used to bridge a Spinner and its morphic representation.
"
Class {
	#name : 'SpMorphicSpinnerAdapter',
	#superclass : 'SpAbstractMorphicAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'factory' }
SpMorphicSpinnerAdapter >> buildWidget [
	^ SpSpinnerMorph new
]
