"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubLabelAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubLabelAdapter >> buildWidget [

	^ SpStubLabelAdapter new
]
