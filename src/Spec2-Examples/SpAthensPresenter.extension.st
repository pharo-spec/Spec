Extension { #name : #SpAthensPresenter }

{ #category : #'*Spec2-Examples' }
SpAthensPresenter class >> example [
	"Show an athens (vectorial graphics) component embedded into a spec window presenter"
	| extent |

	extent := 350@300.
	self new
		surfaceExtent: extent;
		drawBlock: [ :aCanvas | | paint surface |
			surface := aCanvas surface.
			paint := surface
				createLinearGradient: {
					0->Color red.
					1->Color green }
				start: 0@0
				stop: extent.
			surface clear.
			aCanvas setPaint: paint.
			aCanvas drawShape: (0@0 corner: extent) ];
		open
]

{ #category : #'*Spec2-Examples' }
SpAthensPresenter class >> exampleResizing [
	"Show an athens (vectorial graphics) component embedded into a spec window presenter.
It shows also how it resizes the athens component when the window is resized."
	| extent |

	extent := 350@300.
	self new
		surfaceExtent: extent;
		drawBlock: [ :aCanvas :boundingBox | | paint surface |
			"Since sometimes a cairo surface does not brings the correct extent (in X11 or Windows,
			 for example), we use the bounding box of the component."
			surface := aCanvas surface.
			paint := surface
				createLinearGradient: {
					0->Color red.
					1->Color green }
				start: 0@0
				stop: boundingBox extent.
			surface clear.
			aCanvas setPaint: paint.
			aCanvas drawShape: (0@0 extent: boundingBox extent) ];
		open
]
