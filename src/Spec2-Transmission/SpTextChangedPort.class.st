"
! Text Changed Output Port (==SpTextChangedPort==)
A """"text changed output port"""" will handle the transmission when an input presenter content changes.

The presenter exposing a selection output port need to define also the event ==#whenTextChangedDo:==.

Presenters exposing this port: *class:SpAbstractTextPresenter* subclasses.
"
Class {
	#name : 'SpTextChangedPort',
	#superclass : 'SpOutputPort',
	#category : 'Spec2-Transmission-Base',
	#package : 'Spec2-Transmission',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpTextChangedPort class >> portName [
	^ #changed
]

{ #category : 'attaching' }
SpTextChangedPort >> attachTransmission: aTransmission to: aPresenter [

	aPresenter whenTextChangedDo: [ :aString | 
		self 
			transmitWith: aTransmission 
			value: (self applyTransform: aString) ]
]
