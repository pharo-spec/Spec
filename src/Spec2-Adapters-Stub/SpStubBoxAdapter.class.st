Class {
	#name : 'SpStubBoxAdapter',
	#superclass : 'SpStubLayoutAdapter',
	#category : 'Spec2-Adapters-Stub-Adapters',
	#package : 'Spec2-Adapters-Stub',
	#tag : 'Adapters'
}

{ #category : 'factory' }
SpStubBoxAdapter >> basicAdd: aPresenter constraints: constraints to: aPanel [
]

{ #category : 'factory' }
SpStubBoxAdapter >> buildWidget [
	^ SpStubBoxView new
]
