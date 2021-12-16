"
I'm an example of an Option List (mac style).
My options reuse a layout already defined in other examples.
"
Class {
	#name : #SpOptionListExample,
	#superclass : #SpOptionListPresenter,
	#category : #'Spec2-Examples-Standalone'
}

{ #category : #examples }
SpOptionListExample class >> example [
	self new openWithSpec
]

{ #category : #examples }
SpOptionListExample class >> exampleDialog [
	self new openDialogWithSpec
]

{ #category : #initialization }
SpOptionListExample >> allOptions [

	^ { SpDemoFormPresenter . SpDemoImagePresenter . SpOptionPresenterExample }
		collect: [ :class | class new ]
]

{ #category : #initialization }
SpOptionListExample >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Spec Option List demos';
		initialExtent: 800@500
]
