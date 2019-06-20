"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : #SpStubIconListAdapter,
	#superclass : #SpStubAbstractAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubIconListAdapter >> buildWidget [

	^ SpStubIconListView new
]
