"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubNumberInputFieldAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubNumberInputFieldAdapter >> buildWidget [
	^ SpStubNumberInputFieldView new
]
