"
I am the adapter used to bridge a TickingWindowPresenter and a TickingSpecWindow
"
Class {
	#name : #SpMorphicTickingWindowAdapter,
	#superclass : #SpMorphicWindowAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #factory }
SpMorphicTickingWindowAdapter >> buildWidget [
	^ TickingSpecWindow new
			model: self;
			isResizeable: self isResizeable;
			yourself
]

{ #category : #stepping }
SpMorphicTickingWindowAdapter >> step [
	self model step
]
