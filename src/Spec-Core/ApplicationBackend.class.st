"
I'm a backend for a Spec applications. 
Backends define different things from an application: 
- which UI backend will use (Morphic by default), 
- access to system resources
- access to standard dialogs usually residing in the operating system (but also simulated)
- ...
"
Class {
	#name : #ApplicationBackend,
	#superclass : #Object,
	#instVars : [
		'adapterBindings'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
ApplicationBackend class >> backendName [

	^ self subclassResponsibility
]

{ #category : #accessing }
ApplicationBackend class >> findBackendNamed: aName [

	^ (self allSubclasses 
		detect: [ :each | each backendName = aName ])
		new	
]

{ #category : #accessing }
ApplicationBackend >> adapterBindings [

	^ adapterBindings
]

{ #category : #private }
ApplicationBackend >> adapterBindingsClass [

	self subclassResponsibility
]

{ #category : #initialization }
ApplicationBackend >> initialize [

	super initialize.
	adapterBindings := self adapterBindingsClass
]

{ #category : #accessing }
ApplicationBackend >> name [

	^ self class backendName
]
