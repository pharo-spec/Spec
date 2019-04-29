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
