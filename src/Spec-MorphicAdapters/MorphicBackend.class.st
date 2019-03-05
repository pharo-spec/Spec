Class {
	#name : #MorphicBackend,
	#superclass : #ApplicationBackend,
	#category : #'Spec-MorphicAdapters-Backend'
}

{ #category : #accessing }
MorphicBackend class >> backendName [

	^ #Morphic
]

{ #category : #private }
MorphicBackend >> adapterBindingsClass [

	^ MorphicAdapterBindings
]
