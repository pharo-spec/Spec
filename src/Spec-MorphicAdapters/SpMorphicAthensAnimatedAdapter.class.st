Class {
	#name : #SpMorphicAthensAnimatedAdapter,
	#superclass : #SpMorphicAthensStaticAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #initialization }
SpMorphicAthensAnimatedAdapter >> updateModelToMoment: tick [
	self widget changed
]
