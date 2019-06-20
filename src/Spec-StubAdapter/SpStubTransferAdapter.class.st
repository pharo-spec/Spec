"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubTransferAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubTransferAdapter >> buildWidget [

	^ SpStubTransferView new
]
