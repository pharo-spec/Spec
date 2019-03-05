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
		'ActiveApplication'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
SpecApplication class >> activeApplication [
	"An application is activated always that a window is activated. 
	 This means: when a window receives the focus, it will set its own application as 
	 active application (to ensure other applications created by it will be executed 
	 in the same context). 
	 You can explicit the application of a presenter using: 
		- Application >> newPresenter:
		- Presenter class >> newApplication:"

	^ ActiveApplication contents
]

{ #category : #accessing }
SpecApplication class >> activeApplication: anApplication [
	
	ActiveApplication contents: anApplication
]

{ #category : #accessing }
SpecApplication class >> activeApplicationOrDefault [

	^ self activeApplication 
		ifNil: [ self defaultApplication ]
]

{ #category : #accessing }
SpecApplication class >> defaultApplication [

	^ DefaultApplication ifNil: [ DefaultApplication := SpecNullApplication new ]
]

{ #category : #accessing }
SpecApplication class >> defaultBackendName [

	^ #Morphic
]

{ #category : #accessing }
SpecApplication class >> initialize [

	ActiveApplication := SpecWeakValueHolder new
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

	^ SpecBindings 
		value: self backend adapterBindings 	
		during: [ 
			| window |
			window := aWindowClass presenter: aPresenter.
			window openWithSpecLayout: aSpecLayout.
			aPresenter announcer announce: (WindowBuilt new 
				model: window;
				window: window;
				yourself).
			window ]
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

{ #category : #starting }
SpecApplication >> start [ 
	"Override this to start your app"
]

{ #category : #accessing }
SpecApplication >> useBackend: aName [

	backend := SpecApplicationBackend findBackendNamed: aName
]
