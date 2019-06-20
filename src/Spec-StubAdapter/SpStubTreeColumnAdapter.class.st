"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubTreeColumnAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubTreeColumnAdapter >> buildWidget [

	^ SpStubTreeColumnView new
]
