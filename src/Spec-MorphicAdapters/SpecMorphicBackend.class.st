Class {
	#name : #SpecMorphicBackend,
	#superclass : #SpecBackend,
	#category : #'Spec-MorphicAdapters-Backend'
}

{ #category : #accessing }
SpecMorphicBackend class >> backendName [

	^ #morphic
]

{ #category : #private }
SpecMorphicBackend >> newAdapterBindings [

	^ MorphicAdapterBindings
]
