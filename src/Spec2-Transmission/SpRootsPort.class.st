Class {
	#name : #SpRootsPort,
	#superclass : #SpInputPort,
	#category : #'Spec2-Transmission-Base'
}

{ #category : #'handling transmission' }
SpRootsPort >> applyIncomingTransmission: anObject from: outPort to: aPresenter [

	aPresenter roots: anObject
]
