"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubImageAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubImageAdapter >> buildWidget [

	^ SpStubImageView new
]
