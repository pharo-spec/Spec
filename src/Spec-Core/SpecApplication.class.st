"
I'm a Spec application entry point. 
In Spec, each application needs to have a definition that concentrates its flow and resources.

"
Class {
	#name : #SpecApplication,
	#superclass : #Object,
	#instVars : [
		'backend'
	],
	#classVars : [
		'DefaultApplication'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
SpecApplication class >> defaultApplication [

	^ DefaultApplication ifNil: [ DefaultApplication := SpecNullApplication new ]
]

{ #category : #accessing }
SpecApplication class >> defaultBackendName [

	^ #Morphic
]

{ #category : #accessing }
SpecApplication >> adapterBindings [
	
	^ self backend adapterBindings
]

{ #category : #accessing }
SpecApplication >> backend [

	^ backend ifNil: [ 
		self useBackend: self class defaultBackendName.
		backend ]
]

{ #category : #testing }
SpecApplication >> isPresenter [ 
	"Presenters use this to track application/rootPresenter."

	^ false
]

{ #category : #factory }
SpecApplication >> new: aPresenter [
	"a synonym for #newPresenter:"
	
	^ self newPresenter: aPresenter
]

{ #category : #factory }
SpecApplication >> newPresenter: aPresenterClass [

	^ aPresenterClass newApplication: self
]

{ #category : #showing }
SpecApplication >> open: aPresenter withSpecLayout: aSpecLayout [

	^ self 
		open: aPresenter 
		withSpecLayout: aSpecLayout 
		using: WindowPresenter
]

{ #category : #'private showing' }
SpecApplication >> open: aPresenter withSpecLayout: aSpecLayout using: aWindowClass [
	| window |

	window := aWindowClass presenter: aPresenter.
	window openWithSpecLayout: aSpecLayout.
	aPresenter announcer announce: (WindowBuilt new 
		model: window;
		window: window;
		yourself).

	^ window
]

{ #category : #showing }
SpecApplication >> openDialog: aPresenter withSpecLayout: aSpecLayout [

	^ self 
		open: aPresenter 
		withSpecLayout: aSpecLayout 
		using: DialogWindowPresenter
]

{ #category : #showing }
SpecApplication >> openModal: aPresenter withSpecLayout: aSpecLayout [

	^ self 
		open: aPresenter 
		withSpecLayout: aSpecLayout 
		using: ModalWindowPresenter
]

{ #category : #running }
SpecApplication >> run [ 

	self start
]

{ #category : #running }
SpecApplication >> start [ 
	"Override this to start your app"
]

{ #category : #accessing }
SpecApplication >> useBackend: aName [

	backend := SpecApplicationBackend findBackendNamed: aName
]
