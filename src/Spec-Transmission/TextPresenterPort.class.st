"
I define an incomming transmission to modify the text of a text style presenter (input fields or text areas).
"
Class {
	#name : #TextPresenterPort,
	#superclass : #InputPresenterPort,
	#category : #'Spec-Transmission'
}

{ #category : #accessing }
TextPresenterPort class >> portName [

	^ #text
]

{ #category : #'handling transmission' }
TextPresenterPort >> incomingTransmission: anObject from: outPort [

	self destinationPresenter text: anObject
]
