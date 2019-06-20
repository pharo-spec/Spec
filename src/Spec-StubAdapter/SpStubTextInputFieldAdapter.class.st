"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubTextInputFieldAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubTextInputFieldAdapter >> buildWidget [

	^ SpStubTextInputFieldView new
]
