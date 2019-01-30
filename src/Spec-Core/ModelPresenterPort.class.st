Class {
	#name : #ModelPresenterPort,
	#superclass : #InputPresenterPort,
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
ModelPresenterPort class >> portName [
	
	^ #model
]

{ #category : #'as yet unclassified' }
ModelPresenterPort >> incomingTransmission: anObject from: aTransmission [

	self presenter setModel: anObject
]
