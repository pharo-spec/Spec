"
I define an incomming transmission to modify the model of a presenter.
"
Class {
	#name : #ModelPresenterPort,
	#superclass : #InputPresenterPort,
	#category : #'Spec-Transmission'
}

{ #category : #accessing }
ModelPresenterPort class >> portName [
	
	^ #model
]

{ #category : #'handling transmission' }
ModelPresenterPort >> incomingTransmission: anObject from: aTransmission [

	self destinationPresenter setModel: anObject
]
