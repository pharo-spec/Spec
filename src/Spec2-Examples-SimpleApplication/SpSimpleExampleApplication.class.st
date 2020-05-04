"
I am a simple example application, to show basic concepts of Spec.

! A (simple) sample application
This is the starting point of every Spec application. A subclass of *SpApplication* who defines how your application will behave and start.

You will need to override ==initialize== and ==start== methods as a begining.

"
Class {
	#name : #SpSimpleExampleApplication,
	#superclass : #SpApplication,
	#category : #'Spec2-Examples-SimpleApplication'
}

{ #category : #accessing }
SpSimpleExampleApplication class >> start [

	
]

{ #category : #initialization }
SpSimpleExampleApplication >> initialize [
	"The configuration point for this application can be defined here. 
	 Sending #useBackend:with: you will declare your application to use a morphic application and 
	 use a *SpSimpleExampleConfiguration* instance as configuration.

	[[[language=Smalltalk
		self 
			useBackend: #Morphic 
			with: SpSimpleExampleConfiguration new.
	]]]"

	super initialize.
	self useBackend: #Morphic with: SpSimpleExampleConfiguration new
]

{ #category : #accessing }
SpSimpleExampleApplication >> start [
	"You will declare your initial window here (spec is, after all, a framework to create desktop 
	 applications).
	
	[[[language=Smalltalk
		(self new: SpSimpleExamplePresenter) openWithSpec.
	]]]
	"

	(self new: SpSimpleExamplePresenter) openWithSpec
]
