Extension { #name : 'SpAlexandriePresenter' }

{ #category : '*Spec2-Examples' }
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

{ #category : '*Spec2-Examples' }
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
