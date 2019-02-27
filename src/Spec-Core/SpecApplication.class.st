Class {
	#name : #SpecApplication,
	#superclass : #Object,
	#instVars : [
		'backend'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
SpecApplication class >> defaultBackend [

	^ #morphic
]

{ #category : #accessing }
SpecApplication >> adapterBindings [
	
	^ self backend adapterBindings
]

{ #category : #accessing }
SpecApplication >> backend [

	^ backend ifNil: [ 
		self useBackend: self class defaultBackend.
		backend ]
]

{ #category : #testing }
SpecApplication >> isNullApplication [

	^ false
]

{ #category : #testing }
SpecApplication >> isPresenter [ 
	"Presenters use this to track application/rootPresenter."

	^ false
]

{ #category : #starting }
SpecApplication >> start [ 
	"Override this to start your app"
]

{ #category : #accessing }
SpecApplication >> useBackend: aName [

	backend := SpecBackend findBackendNamed: aName
]
