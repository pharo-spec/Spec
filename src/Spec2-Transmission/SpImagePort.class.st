"
An **image input port** defines an incomming transmission to modify the image of an image presenter.

Presenter exposing this port: `SpImagePresenter`
"
Class {
	#name : 'SpImagePort',
	#superclass : 'SpInputPort',
	#category : 'Spec2-Transmission-Base',
	#package : 'Spec2-Transmission',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpImagePort class >> portName [

	^ #image
]

{ #category : 'handling transmission' }
SpImagePort >> applyIncomingTransmission: anObject from: outPort to: aPresenter [
	
	aPresenter image: anObject
]
