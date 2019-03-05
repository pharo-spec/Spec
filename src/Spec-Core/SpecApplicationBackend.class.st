"
I'm a backend for a Spec applications. 
Backends define different things from an application: 
- which UI backend will use (Morphic by default), 
- access to system resources
- access to standard dialogs usually residing in the operating system (but also simulated)
- ...
"
Class {
	#name : #SpecApplicationBackend,
	#superclass : #Object,
	#instVars : [
		'adapterBindings'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
SpecApplicationBackend class >> backendName [

	^ self subclassResponsibility
]

{ #category : #accessing }
SpecApplicationBackend class >> findBackendNamed: aName [

	^ (self allSubclasses 
		detect: [ :each | each backendName = aName ])
		new	
]

{ #category : #accessing }
SpecApplicationBackend >> adapterBindings [

	^ adapterBindings
]

{ #category : #private }
SpecApplicationBackend >> adapterBindingsClass [

	self subclassResponsibility
]

{ #category : #initialization }
SpecApplicationBackend >> initialize [

	super initialize.
	adapterBindings := self adapterBindingsClass
]

{ #category : #accessing }
SpecApplicationBackend >> name [

	^ self class backendName
]
