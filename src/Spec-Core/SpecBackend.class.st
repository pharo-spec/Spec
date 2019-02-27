Class {
	#name : #SpecBackend,
	#superclass : #Object,
	#instVars : [
		'adapterBindings'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
SpecBackend class >> backendName [

	^ self subclassResponsibility
]

{ #category : #accessing }
SpecBackend class >> findBackendNamed: aName [

	^ (self allSubclasses 
		detect: [ :each | each backendName = aName ])
		new	
]

{ #category : #accessing }
SpecBackend >> adapterBindings [

	^ adapterBindings
]

{ #category : #initialization }
SpecBackend >> initialize [

	super initialize.
	adapterBindings := self newAdapterBindings
]

{ #category : #private }
SpecBackend >> newAdapterBindings [

	self subclassResponsibility
]
