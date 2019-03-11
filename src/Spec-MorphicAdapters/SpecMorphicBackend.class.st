Class {
	#name : #SpecMorphicBackend,
	#superclass : #SpecApplicationBackend,
	#category : #'Spec-MorphicAdapters-Backend'
}

{ #category : #accessing }
SpecMorphicBackend class >> backendName [

	^ #Morphic
]

{ #category : #private }
SpecMorphicBackend >> adapterBindingsClass [

	^ MorphicAdapterBindings
]
