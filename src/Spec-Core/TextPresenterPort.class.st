Class {
	#name : #TextPresenterPort,
	#superclass : #InputPresenterPort,
	#category : #'Spec-Core-Transmission'
}

{ #category : #accessing }
TextPresenterPort class >> portName [

	^ #text
]

{ #category : #'handling transmission' }
TextPresenterPort >> incomingTransmission: anObject from: outPort [

	self destinationPresenter text: anObject
]
