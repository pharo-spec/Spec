"
I define an incomming transmission to modify the model of a presenter.
"
Class {
	#name : #SpModelPort,
	#superclass : #SpInputPort,
	#category : #'Spec-Transmission-Base'
}

{ #category : #accessing }
SpModelPort class >> portName [
	
	^ #model
]

{ #category : #'handling transmission' }
SpModelPort >> incomingTransmission: anObject from: aTransmission [

	self destinationPresenter setModel: anObject
]
