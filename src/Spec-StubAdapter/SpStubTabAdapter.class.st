"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubTabAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubTabAdapter >> buildWidget [

	^ SpStubTabView new
]
