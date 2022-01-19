"
I am a model representing Pharo World.

This way, every spec application can be opened as the Pharo system window as window, to simulate native a application.
"
Class {
	#name : #SpWorldPresenter,
	#superclass : #SpWindowPresenter,
	#instVars : [
		'widget'
	],
	#category : #'Spec2-Morphic-Widgets'
}

{ #category : #specs }
SpWorldPresenter class >> defaultSpec [
	self setUpWorld.
	^ SpAbstractWidgetLayout for: #WorldAdapter
]

{ #category : #private }
SpWorldPresenter class >> setUpWorld [

	self currentWorld changeProportionalLayout.
	self currentWorld submorphs do: [:e | e delete ].
 
 	(Smalltalk at: #PolymorphSystemSettings) 
		perform: #desktopColor: 
		with: self currentWorld theme backgroundColor.
 	"((Smalltalk at: #UITheme) perform: #currentSettings) perform: #windowColor: with: (Color r: 0.745 g: 0.745 b: 0.745)."
	(Smalltalk at: #TaskbarMorph) perform: #showTaskbar: with: false
]

{ #category : #private }
SpWorldPresenter >> addPresenterIn: container withSpecLayout: aSpec [

	self presenter ifNil: [ ^ self ].
	self 
		changed: #addPresenterIn:withSpecLayout:
		with: { container. aSpec }
]

{ #category : #private }
SpWorldPresenter >> defaultInitialExtent [
	
	^ self currentWorld extent
]

{ #category : #api }
SpWorldPresenter >> ensureExtentFor: aWidget [

	self extent ifNotNil: [ :ext | DisplayScreen hostWindowSize: ext ].
	self initialExtent ifNotNil: [ :ext | DisplayScreen hostWindowSize: ext ].
]

{ #category : #api }
SpWorldPresenter >> isDisplayed [

	^ true
]

{ #category : #private }
SpWorldPresenter >> openWithLayout: aSpecLayout [

	self flag: 'Is it really neeed to redefine this method in World presenter?'.
	
	self buildWithSpecLayout: aSpecLayout.
	self updateTitle
]

{ #category : #private }
SpWorldPresenter >> updateTitle [
	"Update the window title"

	self title: self title
]

{ #category : #api }
SpWorldPresenter >> widget [

	^ widget 
]
