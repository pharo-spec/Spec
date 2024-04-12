"
! Label Input Port (==SpLabelPort==)
A """"label input port"""" define an incomming transmission to modify the label of alabel presenter.

The presenter exposing a text input port need to define also the method ==#label:==.

Presenters exposing this port: *class:SpLabelPresenter*.
"
Class {
	#name : 'SpLabelPort',
	#superclass : 'SpInputPort',
	#category : 'Spec2-Transmission-Base',
	#package : 'Spec2-Transmission',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpLabelPort class >> portName [

	^ #text
]

{ #category : 'handling transmission' }
SpLabelPort >> applyIncomingTransmission: anObject from: outPort to: aPresenter [

	aPresenter label: anObject
]
