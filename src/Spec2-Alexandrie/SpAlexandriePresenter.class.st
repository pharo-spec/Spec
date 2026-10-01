Class {
	#name : 'SpAlexandriePresenter',
	#superclass : 'SpAbstractWidgetPresenter',
	#traits : 'SpTContextMenu',
	#classTraits : 'SpTContextMenu classTrait',
	#instVars : [
		'#drawBlock => ObservableSlot',
		'#surfaceExtent => ObservableSlot'
	],
	#category : 'Spec2-Alexandrie',
	#package : 'Spec2-Alexandrie'
}

{ #category : 'specs' }
SpAlexandriePresenter class >> adapterName [

	^ #AlexandrieAdapter
]

{ #category : 'defaults' }
SpAlexandriePresenter class >> defaultSurfaceExtent [

	^ 300@300
]

{ #category : 'documentation' }
SpAlexandriePresenter class >> documentFactoryMethodSelector [

	^ #newAlexandrie
]

{ #category : 'examples' }
SpAlexandriePresenter class >> example [
	"Show an Alexandrie (vectorial graphics) component embedded into a Spec window presenter."

	| extent |
	extent := 350 @ 300.
	self new
		surfaceExtent: extent;
		drawBlock: [ :aContext :boundingBox |
			| gradient |
			gradient := AeCairoLinearGradientPattern 
				from: 0@0 
				to: extent 
				addStopsFrom: {
					(0 -> Color red).
					(1 -> Color green) }.
			aContext
				sourcePattern: gradient;
				roundedRectangleTo: extent radius: 16;
				fill ];
		open
]

{ #category : 'examples' }
SpAlexandriePresenter class >> exampleResizing [
	"Show an Alexandrie component that adapts to the available space.
	Resize the window to see the figure follow the drawing area."

	self new
		surfaceExtent: 350 @ 300;
		drawBlock: [ :aContext :boundingBox |
			| gradient center radius |
			center := boundingBox center.
			radius := (boundingBox width min: boundingBox height) / 2 - 10.
			gradient := AeCairoRadialGradientPattern center: center innerRadius: 0 outerRadius: radius.
			gradient addStopsFrom: {
						(0 -> Color orange).
						(1 -> Color blue) }.
			aContext
				sourcePattern: gradient;
				circleCenter: center radius: radius;
				fill ];
		open
]

{ #category : 'api' }
SpAlexandriePresenter >> drawBlock [
	"Answer the block used to draw into an athens canvas."

	^ drawBlock
]

{ #category : 'api' }
SpAlexandriePresenter >> drawBlock: aBlock [
	"Set the block used to draw into the athens canvas.
	 `aBlock` receives one argument, the `AthensCanvas` instance used to draw the surface.
	 (See `SpAthensPresenter class>>#example` as an example of usage)"

	drawBlock := aBlock
]

{ #category : 'initialization' }
SpAlexandriePresenter >> initialize [

	super initialize.
	self surfaceExtent: self class defaultSurfaceExtent
]

{ #category : 'api' }
SpAlexandriePresenter >> redraw [

	self withAdapterDo: [ :anAdapter | anAdapter redraw ]
]

{ #category : 'api' }
SpAlexandriePresenter >> surfaceExtent [
	"Anwer the surface extent (the size the surface will have)"

	^ surfaceExtent
]

{ #category : 'api' }
SpAlexandriePresenter >> surfaceExtent: anExtent [
	"Set surface extent (a point) to contain the athens drawing."

	surfaceExtent := anExtent
]

{ #category : 'api - events' }
SpAlexandriePresenter >> whenDrawBlockChangedDo: aBlock [
	"Inform when drawBlock has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #drawBlock whenChangedDo: aBlock 
]

{ #category : 'api - events' }
SpAlexandriePresenter >> whenExtentChangedDo: aBlock [
	"Inform when the Athens surface extent has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #surfaceExtent whenChangedDo: aBlock 
]
