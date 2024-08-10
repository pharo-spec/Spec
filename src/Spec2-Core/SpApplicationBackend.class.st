"
I'm a backend for a Spec applications. 
Backends define different things from an application: 
- which UI backend will use (Morphic by default), 
- access to system resources (such as icons),
- access to standard dialogs usually residing in the operating system (but also simulated)
- ...
"
Class {
	#name : 'SpApplicationBackend',
	#superclass : 'Object',
	#instVars : [
		'adapterBindings'
	],
	#category : 'Spec2-Core-Support',
	#package : 'Spec2-Core',
	#tag : 'Support'
}

{ #category : 'accessing' }
SpApplicationBackend class >> backendName [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
SpApplicationBackend class >> findBackendNamed: aName [

	^ (self allSubclasses 
		detect: [ :each | each backendName = aName ])
		new	
]

{ #category : 'accessing' }
SpApplicationBackend >> adapterBindings [

	^ adapterBindings
]

{ #category : 'private' }
SpApplicationBackend >> adapterBindingsClass [

	self subclassResponsibility
]

{ #category : 'accessing' }
SpApplicationBackend >> componentListClass [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
SpApplicationBackend >> defaultConfigurationFor: anApplication [

	^ self subclassResponsibility
]

{ #category : 'accessing' }
SpApplicationBackend >> dropListClass [

	self subclassResponsibility
]

{ #category : 'ui - dialogs' }
SpApplicationBackend >> inform: aString [

	self subclassResponsibility
]

{ #category : 'initialization' }
SpApplicationBackend >> initialize [

	super initialize.
	self resetAdapterBindings
]

{ #category : 'accessing' }
SpApplicationBackend >> listClass [

	self subclassResponsibility
	
]

{ #category : 'accessing' }
SpApplicationBackend >> name [

	^ self class backendName
]

{ #category : 'ui - notifying' }
SpApplicationBackend >> notifyError: aSpecNotification [

	self subclassResponsibility
]

{ #category : 'ui - notifying' }
SpApplicationBackend >> notifyInfo: aSpecNotification [

	self subclassResponsibility
]

{ #category : 'ui - dialogs' }
SpApplicationBackend >> openFileDialog: aFileDialog [

	self subclassResponsibility
]

{ #category : 'initialization' }
SpApplicationBackend >> resetAdapterBindings [

	adapterBindings := self adapterBindingsClass new
]

{ #category : 'ui' }
SpApplicationBackend >> showWaitCursorWhile: aBlock inApplication: anApplication [

	self subclassResponsibility
]

{ #category : 'accessing' }
SpApplicationBackend >> tableClass [

	self subclassResponsibility
]

{ #category : 'accessing' }
SpApplicationBackend >> treeClass [

	self subclassResponsibility
	
]

{ #category : 'accessing' }
SpApplicationBackend >> treeTableClass [

	self subclassResponsibility
]
