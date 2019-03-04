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
		self useBackend: self class defaultBackend.
		backend ]
]

{ #category : #testing }
Application >> isNullApplication [

	^ false
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
			window openWithSpecLayout: aSpecLayout ]
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

	backend := SpecBackend findBackendNamed: aName
]
