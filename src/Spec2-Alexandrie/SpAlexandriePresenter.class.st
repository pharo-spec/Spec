Class {
	#name : #SpAlexandriePresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#traits : 'SpTContextMenu',
	#classTraits : 'SpTContextMenu classTrait',
	#instVars : [
		'#drawBlock => ObservableSlot',
		'#surfaceExtent => ObservableSlot'
	],
	#category : #'Spec2-Alexandrie'
}

{ #category : #specs }
SpAlexandriePresenter class >> adapterName [

	^ #AlexandrieAdapter
]

{ #category : #defaults }
SpAlexandriePresenter class >> defaultSurfaceExtent [

	^ 300@300
]

{ #category : #documentation }
SpAlexandriePresenter class >> documentFactoryMethodSelector [

	^ #newAlexandrie
]

{ #category : #api }
SpAlexandriePresenter >> drawBlock [
	"Answer the block used to draw into an athens canvas."

	^ drawBlock
]

{ #category : #api }
SpAlexandriePresenter >> drawBlock: aBlock [
	"Set the block used to draw into the athens canvas.
	 `aBlock` receives one argument, the `AthensCanvas` instance used to draw the surface.
	 (See `SpAthensPresenter class>>#example` as an example of usage)"

	drawBlock := aBlock
]

{ #category : #initialization }
SpAlexandriePresenter >> initialize [

	super initialize.
	self surfaceExtent: self class defaultSurfaceExtent
]

{ #category : #api }
SpAlexandriePresenter >> redraw [

	self withAdapterDo: [ :anAdapter | anAdapter redraw ]
]

{ #category : #api }
SpAlexandriePresenter >> surfaceExtent [
	"Anwer the surface extent (the size the surface will have)"

	^ surfaceExtent
]

{ #category : #api }
SpAlexandriePresenter >> surfaceExtent: anExtent [
	"Set surface extent (a point) to contain the athens drawing."

	surfaceExtent := anExtent
]

{ #category : #'api - events' }
SpAlexandriePresenter >> whenDrawBlockChangedDo: aBlock [
	"Inform when drawBlock has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #drawBlock whenChangedDo: aBlock 
]

{ #category : #'api - events' }
SpAlexandriePresenter >> whenExtentChangedDo: aBlock [
	"Inform when the Athens surface extent has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #surfaceExtent whenChangedDo: aBlock 
]
