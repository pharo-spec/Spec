"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubTabManagerAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubTabManagerAdapter >> buildWidget [

	^ SpStubTabManagerView new
]
