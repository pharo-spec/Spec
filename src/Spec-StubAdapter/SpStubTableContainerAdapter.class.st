"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubTableContainerAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubTableContainerAdapter >> buildWidget [

	^ SpStubTableContainerView new
]
