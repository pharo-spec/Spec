Class {
	#name : #RootsPresenterPort,
	#superclass : #SpInputPort,
	#category : #'Spec-Transmission'
}

{ #category : #'handling transmission' }
RootsPresenterPort >> incomingTransmission: anObject from: outPort [

	self presenter roots: anObject
]
