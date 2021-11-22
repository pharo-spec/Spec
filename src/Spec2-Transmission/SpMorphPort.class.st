"
I define an incomming transmission to modify the morph value of a presenter.
I'm used on MorphPresenter.
"
Class {
	#name : #SpMorphPort,
	#superclass : #SpInputPort,
	#category : #'Spec2-Transmission-Base'
}

{ #category : #accessing }
SpMorphPort class >> portName [

	^ #morph
]

{ #category : #'handling transmission' }
SpMorphPort >> applyIncomingTransmission: anObject from: outPort to: aPresenter [

	aPresenter morph: anObject
]
