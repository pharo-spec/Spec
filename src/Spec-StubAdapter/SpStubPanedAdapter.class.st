Class {
	#name : #SpStubPanedAdapter,
	#superclass : #SpStubLayoutAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubPanedAdapter >> buildWidget [
	^ SpStubPanedView new
]
