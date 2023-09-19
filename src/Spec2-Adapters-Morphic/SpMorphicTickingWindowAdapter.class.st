"
I am the adapter used to bridge a TickingWindowPresenter and a TickingSpecWindow
"
Class {
	#name : 'SpMorphicTickingWindowAdapter',
	#superclass : 'SpMorphicWindowAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'factory' }
SpMorphicTickingWindowAdapter >> buildWidget [

	^ SpTickingSpecWindow new
		  model: self;
		  isResizeable: self isResizable;
		  yourself
]

{ #category : 'stepping' }
SpMorphicTickingWindowAdapter >> step [

	self model step
]
