Class {
	#name : #ApplicationBackendMorphic,
	#superclass : #ApplicationBackend,
	#category : #'Spec-MorphicAdapters-Backend'
}

{ #category : #accessing }
ApplicationBackendMorphic class >> backendName [

	^ #morphic
]

{ #category : #private }
ApplicationBackendMorphic >> newAdapterBindings [

	^ MorphicAdapterBindings
]
