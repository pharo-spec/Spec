"
I'm an input accepted transmission. 
I will handle the transmission when an input presenter accept its content.
"
Class {
	#name : #SpecTextAcceptedPort,
	#superclass : #SpecOutputPort,
	#category : #'Spec-Transmission-Base'
}

{ #category : #accessing }
SpecTextAcceptedPort class >> portName [
	^ #accepted
]

{ #category : #attaching }
SpecTextAcceptedPort >> attachTransmission: aTransmission [
	self destinationPresenter whenTextIsAcceptedDo: [ :selection | self transmitWith: aTransmission value: selection text ]
]
