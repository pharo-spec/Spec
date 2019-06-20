"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubMenuAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubMenuAdapter >> buildWidget [

	^ SpStubMenuView new
]
