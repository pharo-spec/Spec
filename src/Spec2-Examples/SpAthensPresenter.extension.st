Extension { #name : #SpAthensPresenter }

{ #category : #'*Spec2-Examples' }
SpAthensPresenter class >> example [
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
		openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpAthensPresenter class >> exampleResizing [
	| extent |
	
	extent := 350@300.
	self new
		application: (SpApplication new useBackend: #Gtk);
		surfaceExtent: extent;
		drawBlock: [ :aCanvas | | paint surface |
			surface := aCanvas surface.
			paint := surface 
				createLinearGradient: { 
					0->Color red. 
					1->Color green } 
				start: 0@0 
				stop: surface extent.
			surface clear.
			aCanvas setPaint: paint.
			aCanvas drawShape: (0@0 corner: surface extent) ]; 
		openWithSpec
]
