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
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
Application class >> defaultAppliction [

	^ NullApplication new
]

{ #category : #accessing }
Application class >> defaultBackend [

	^ #morphic
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
				model: self;
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
