Class {
	#name : #ItemsPresenterPort,
	#superclass : #InputPresenterPort,
	#category : #'Spec-Transmission'
}

{ #category : #accessing }
ItemsPresenterPort class >> portName [

	^ #items
]

{ #category : #'handling transmission' }
ItemsPresenterPort >> incomingTransmission: anObject from: outPort [

	self destinationPresenter items: anObject
]
