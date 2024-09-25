Class {
	#name : 'SpAlexandrieMorph',
	#superclass : 'Morph',
	#instVars : [
		'surface',
		'drawBlock',
		'lastExtent'
	],
	#category : 'Spec2-Adapters-Morphic-Alexandrie-Base',
	#package : 'Spec2-Adapters-Morphic-Alexandrie',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpAlexandrieMorph >> drawBlock: aBlock [

	drawBlock := aBlock
]

{ #category : 'drawing' }
SpAlexandrieMorph >> drawOn: aMorphicCanvas [

	self redraw.
	aMorphicCanvas
		image: self surface asForm
		at: self position
		sourceRect: (0@0 extent: self extent)
		rule: 34
]

{ #category : 'drawing' }
SpAlexandrieMorph >> redraw [
	| context |

	context := self surface newContext. 
	drawBlock 
		cull: context
		cull: (0@0 extent: self extent)
]

{ #category : 'accessing' }
SpAlexandrieMorph >> surface [
 
	lastExtent = self extent ifFalse: [ surface := nil ].
	^ surface ifNil: [ 
		lastExtent := self extent.
		surface := AeCairoImageSurface extent: self extent ]
]
