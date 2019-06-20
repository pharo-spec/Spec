"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubTickingWindowAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubTickingWindowAdapter >> buildWidget [

	^ SpStubTickingWindowView new
]
