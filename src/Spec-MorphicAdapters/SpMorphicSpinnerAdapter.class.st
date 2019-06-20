Class {
	#name : #SpMorphicSpinnerAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'subMenuWidget'
	],
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #factory }
SpMorphicSpinnerAdapter >> buildWidget [
	^ SpinnerMorph new
]
