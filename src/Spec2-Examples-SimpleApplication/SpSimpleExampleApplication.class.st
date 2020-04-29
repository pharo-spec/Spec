Class {
	#name : #SpSimpleExampleApplication,
	#superclass : #SpApplication,
	#category : #'Spec2-Examples-SimpleApplication'
}

{ #category : #accessing }
SpSimpleExampleApplication class >> start [

	(self new: SpSimpleExamplePresenter) openWithSpec
]

{ #category : #initialization }
SpSimpleExampleApplication >> initialize [

	super initialize.
	self useBackend: #Morphic with: SpSimpleExampleConfiguration new
]

{ #category : #running }
SpSimpleExampleApplication >> start [

	(self new: SpSimpleExamplePresenter) openWithSpec
]
