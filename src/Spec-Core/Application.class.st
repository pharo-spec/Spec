"
I'm a Spec application entry point. 
In Spec, each application needs to have a definition that concentrates its flow and resources.

"
Class {
	#name : #Application,
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
Application class >> activeApplication [
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
Application class >> activeApplication: anApplication [
	
	ActiveApplication contents: anApplication
]

{ #category : #accessing }
Application class >> activeApplicationOrDefault [

	^ self activeApplication 
		ifNil: [ self defaultApplication ]
]

{ #category : #accessing }
Application class >> defaultApplication [

	^ NullApplication new
]

{ #category : #accessing }
Application class >> defaultBackendName [

	^ #Morphic
]

{ #category : #accessing }
Application class >> initialize [

	ActiveApplication := WeakValueHolder new
]

{ #category : #accessing }
Application >> adapterBindings [
	
	^ self backend adapterBindings
]

{ #category : #accessing }
Application >> backend [

	^ backend ifNil: [ 
		self useBackend: self class defaultBackendName.
		backend ]
]

{ #category : #testing }
Application >> isPresenter [ 
	"Presenters use this to track application/rootPresenter."

	^ false
]

{ #category : #factory }
Application >> newPresenter: aPresenterClass [

	^ aPresenterClass newApplication: self
]

{ #category : #showing }
Application >> open: aPresenter withSpecLayout: aSpecLayout [

	^ self 
		open: aPresenter 
		withSpecLayout: aSpecLayout 
		using: WindowPresenter
]

{ #category : #'private showing' }
Application >> open: aPresenter withSpecLayout: aSpecLayout using: aWindowClass [

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
Application >> openDialog: aPresenter withSpecLayout: aSpecLayout [

	^ self 
		open: aPresenter 
		withSpecLayout: aSpecLayout 
		using: DialogWindowPresenter
]

{ #category : #showing }
Application >> openModal: aPresenter withSpecLayout: aSpecLayout [

	^ self 
		open: aPresenter 
		withSpecLayout: aSpecLayout 
		using: ModalWindowPresenter
]

{ #category : #starting }
Application >> start [ 
	"Override this to start your app"
]

{ #category : #accessing }
Application >> useBackend: aName [

	backend := ApplicationBackend findBackendNamed: aName
]
