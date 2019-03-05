Class {
	#name : #MockApplicationBackend,
	#superclass : #ApplicationBackend,
	#category : #'Spec-Tests-Core-Base'
}

{ #category : #accessing }
MockApplicationBackend class >> backendName [

	^ #Mock
]

{ #category : #private }
MockApplicationBackend >> adapterBindingsClass [

	^ SpecStubAdapterBindings
]
