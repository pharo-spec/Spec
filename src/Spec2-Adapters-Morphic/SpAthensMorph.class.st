"
It exposes an athens surface in a morph
"
Class {
	#name : #SpAthensMorph,
	#superclass : #Morph,
	#instVars : [
		'surface',
		'drawBlock',
		'lastExtent'
	],
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #accessing }
SpAthensMorph >> drawBlock: aBlock [

	drawBlock := aBlock
]

{ #category : #drawing }
SpAthensMorph >> drawOn: aMorphicCanvas [

	self redraw.
	self surface 
		displayOnMorphicCanvas: aMorphicCanvas 
		at: bounds origin
]

{ #category : #drawing }
SpAthensMorph >> redraw [

	self surface drawDuring: [ :canvas | drawBlock cull: canvas ]
]

{ #category : #accessing }
SpAthensMorph >> surface [
 
	lastExtent = self extent ifFalse: [ surface := nil ].
	^ surface ifNil: [ 
		lastExtent := self extent.
		surface := AthensCairoSurface extent: self extent ]
]
