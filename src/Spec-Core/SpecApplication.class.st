"
I'm a Spec application entry point. 
In Spec, each application needs to have a definition that concentrates its flow and resources.

"
Class {
	#name : #SpecApplication,
	#superclass : #Object,
	#instVars : [
		'backend',
		'windows'
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

{ #category : #'private showing' }
SpecApplication >> announceWindowBuilt: window to: aPresenter [
	"announce window was built as a widget"

	window announcer
		announce: (WidgetBuilt model: window widget: window adapter).

	"announce window was built to its root presenter"
	aPresenter announcer
		announce:
			(WindowBuilt new
				model: window;
				window: window;
				yourself)
]

{ #category : #accessing }
SpecApplication >> backend [

	^ backend ifNil: [ 
		self useBackend: self class defaultBackendName.
		backend ]
]

{ #category : #showing }
SpecApplication >> close [
	
	self windows copy do: #close
]

{ #category : #windows }
SpecApplication >> hasWindow: aWindow [
	
	^ self windows includes: aWindow
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
SpecApplication >> open: aPresenter [

	^ self 
		open: aPresenter 
		withSpecLayout: aPresenter defaultSpec
		using: aPresenter defaultWindowPresenterClass
]

{ #category : #showing }
SpecApplication >> open: aPresenter withSpecLayout: aSpecLayout [

	^ self 
		open: aPresenter 
		withSpecLayout: aSpecLayout 
		using: aPresenter defaultWindowPresenterClass
]

{ #category : #'private showing' }
SpecApplication >> open: aPresenter withSpecLayout: aSpecLayout using: aWindowClass [
	| window |

	self validateApplicationOfPresenter: aPresenter.

	window := aWindowClass presenter: aPresenter.
	self windows add: window.
	window openWithSpecLayout: aSpecLayout.
	
	self announceWindowBuilt: window to: aPresenter.

	^ window
]

{ #category : #showing }
SpecApplication >> openDialog: aPresenter [ 
	
	^ self 
		openDialog: aPresenter 
		withSpecLayout: aPresenter defaultSpec

]

{ #category : #showing }
SpecApplication >> openDialog: aPresenter withSpecLayout: aSpecLayout [

	^ self 
		open: aPresenter 
		withSpecLayout: aSpecLayout 
		using: DialogWindowPresenter
]

{ #category : #showing }
SpecApplication >> openModal: aPresenter [ 
	
	^ self 
		openModal: aPresenter 
		withSpecLayout: aPresenter defaultSpec

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

{ #category : #accessing }
SpecApplication >> useBackend: aName with: aConfiguration [

	self useBackend: aName.
	aConfiguration configure: self
]

{ #category : #'private showing' }
SpecApplication >> validateApplicationOfPresenter: aPresenter [

	aPresenter application == self ifFalse: [ 
		SpecInvalidApplicationError signal: 'The requested presenter has a different application' ]
]

{ #category : #windows }
SpecApplication >> windowClosed: aWindowPresenter [
	
	self windows remove: aWindowPresenter ifAbsent: [  ]
]

{ #category : #accessing }
SpecApplication >> windows [
	
	^ windows ifNil: [ windows := Set new ]
]
