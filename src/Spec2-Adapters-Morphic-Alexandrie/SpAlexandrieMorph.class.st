Class {
	#name : #SpAlexandrieMorph,
	#superclass : #Morph,
	#instVars : [
		'surface',
		'drawBlock',
		'lastExtent'
	],
	#category : #'Spec2-Adapters-Morphic-Alexandrie-Base'
}

{ #category : #accessing }
SpAlexandrieMorph >> drawBlock: aBlock [

	drawBlock := aBlock
]

{ #category : #drawing }
SpAlexandrieMorph >> drawOn: aMorphicCanvas [

	self redraw.
	self surface 
		displayOnMorphicCanvas: aMorphicCanvas 
		at: bounds origin
]

{ #category : #drawing }
SpAlexandrieMorph >> redraw [

	self surface drawDuring: [ :canvas | 
		drawBlock 
			cull: canvas
			cull: (0@0 extent: self extent) ]
]

{ #category : #accessing }
SpAlexandrieMorph >> surface [
 
	lastExtent = self extent ifFalse: [ surface := nil ].
	^ surface ifNil: [ 
		lastExtent := self extent.
		surface := AthensCairoSurface extent: self extent ]
]
