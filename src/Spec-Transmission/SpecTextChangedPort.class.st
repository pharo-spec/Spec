"
I'm an input changed transmission. 
I will handle the transmission when an input presenter content changes.
"
Class {
	#name : #SpecTextChangedPort,
	#superclass : #SpecOutputPort,
	#category : #'Spec-Transmission-Base'
}

{ #category : #accessing }
SpecTextChangedPort class >> portName [
	^ #changed
]

{ #category : #attaching }
SpecTextChangedPort >> attachTransmission: aTransmission [
	self destinationPresenter whenTextChangedDo: [ :selection | self transmitWith: aTransmission value: selection text ]
]
