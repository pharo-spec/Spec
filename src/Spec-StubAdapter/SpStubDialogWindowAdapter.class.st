"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubDialogWindowAdapter,
	#superclass : #SpStubWindowAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubDialogWindowAdapter >> buildWidget [

	^ SpStubDialogWindowView new
]
