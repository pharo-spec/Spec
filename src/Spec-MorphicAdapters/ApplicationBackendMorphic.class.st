Class {
	#name : #ApplicationBackendMorphic,
	#superclass : #ApplicationBackend,
	#category : #'Spec-MorphicAdapters-Backend'
}

{ #category : #accessing }
ApplicationBackendMorphic class >> backendName [

	^ #Morphic
]

{ #category : #private }
ApplicationBackendMorphic >> adapterBindingsClass [

	^ MorphicAdapterBindings
]
