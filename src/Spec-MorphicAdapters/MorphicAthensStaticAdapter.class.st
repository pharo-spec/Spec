Class {
	#name : #MorphicAthensStaticAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #factory }
MorphicAthensStaticAdapter >> buildWidget [
	| instance |
	instance := SpecAthensMorph new.
	self presenter
		whenDrawBlockChangedDo: [ :newBlock | instance drawBlock: newBlock ].
	instance drawBlock: self presenter drawBlock.
	^ instance
]

{ #category : #drawing }
MorphicAthensStaticAdapter >> redraw [
	widget redraw
]
