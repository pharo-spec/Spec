Class {
	#name : #SpStubBoxAdapter,
	#superclass : #SpStubLayoutAdapter,
	#category : #'Spec-StubAdapter-Adapters'
}

{ #category : #factory }
SpStubBoxAdapter >> basicAdd: aPresenter constraints: constraints to: aPanel [
]

{ #category : #factory }
SpStubBoxAdapter >> buildWidget [
	^ SpStubBoxView new
]
