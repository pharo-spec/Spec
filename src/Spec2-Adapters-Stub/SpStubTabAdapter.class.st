"
Adapt the presenter on a stub view that displays no real UI elements.
"
Class {
	#name : 'SpStubTabAdapter',
	#superclass : 'SpStubAbstractAdapter',
	#category : 'Spec2-Adapters-Stub-Adapters',
	#package : 'Spec2-Adapters-Stub',
	#tag : 'Adapters'
}

{ #category : 'factory' }
SpStubTabAdapter >> buildWidget [

	^ SpStubTabView new
]
