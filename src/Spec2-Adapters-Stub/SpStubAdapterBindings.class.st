"
I am used to link the Spec presenter names to the stub adapters that generate no real views.

Usefull  for images or UI managers without possible real UI output or  for tests. Can serve as template for real Spec adapters

Usage:

CurrentSpecDefaultBindings value: SpecStubAdapterBindings during: [ 
	ButtonPresenter new openWithSpec.
].
"
Class {
	#name : 'SpStubAdapterBindings',
	#superclass : 'SpAdapterBindings',
	#category : 'Spec2-Adapters-Stub-Support',
	#package : 'Spec2-Adapters-Stub',
	#tag : 'Support'
}

{ #category : 'initialize' }
SpStubAdapterBindings >> abstractAdapterClass [
	^ SpStubAbstractAdapter
]
