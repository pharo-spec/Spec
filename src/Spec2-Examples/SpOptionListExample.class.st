"
I'm an example of an Option List (mac style).
My options reuse a layout already defined in other examples.
"
Class {
	#name : 'SpOptionListExample',
	#superclass : 'SpOptionListPresenter',
	#category : 'Spec2-Examples-Standalone',
	#package : 'Spec2-Examples',
	#tag : 'Standalone'
}

{ #category : 'examples' }
SpOptionListExample class >> example [

	self new open
]

{ #category : 'examples' }
SpOptionListExample class >> exampleDialog [
	self new openDialog
]

{ #category : 'initialization' }
SpOptionListExample >> allOptions [

	^ { SpProgressBarDemo . SpOptionPresenterExample . SpDemoFormPresenter }
		collect: [ :class | class new ]
]

{ #category : 'initialization' }
SpOptionListExample >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Spec Option List demos';
		initialExtent: 800@500
]
