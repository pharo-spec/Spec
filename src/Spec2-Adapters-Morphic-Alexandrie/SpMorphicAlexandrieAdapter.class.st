Class {
	#name : 'SpMorphicAlexandrieAdapter',
	#superclass : 'SpAbstractMorphicAdapter',
	#category : 'Spec2-Adapters-Morphic-Alexandrie-Base',
	#package : 'Spec2-Adapters-Morphic-Alexandrie',
	#tag : 'Base'
}

{ #category : 'factory' }
SpMorphicAlexandrieAdapter >> buildWidget [

	| instance |
	instance := SpAthensMorph new.
	self presenter whenDrawBlockChangedDo: [ :newBlock | 
		instance drawBlock: newBlock ].
	self presenter whenExtentChangedDo: [ :newExtent | 
		instance extent: newExtent ].
	instance extent: self presenter surfaceExtent.
	instance drawBlock: self presenter drawBlock.
	instance setBalloonText: self model help.
	self presenter whenHelpChangedDo: [ 
		instance setBalloonText: self model help ].
	^ instance
]

{ #category : 'drawing' }
SpMorphicAlexandrieAdapter >> redraw [

	widget redraw
]

{ #category : 'accessing' }
SpMorphicAlexandrieAdapter >> surface [

	^ widget surface
]
