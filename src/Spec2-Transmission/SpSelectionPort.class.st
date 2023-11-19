"
# Selection Output Port (`SpSelectionPort`)
A *selection output port* will handle the transmission when a presenter can be selected (e.g. lists).

The presenter exposing a selection output port need to define also the event `#whenSelectionChangedDo:`.

Presenters exposing this port: `SpAbstractListPresenter` subclasses and `SpTreeTablePresenter`
"
Class {
	#name : 'SpSelectionPort',
	#superclass : 'SpOutputPort',
	#category : 'Spec2-Transmission-Base',
	#package : 'Spec2-Transmission',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpSelectionPort class >> portName [
	
	^ #selection
]

{ #category : 'attaching' }
SpSelectionPort >> attachTransmission: aTransmission to: aPresenter [
		
	aPresenter whenSelectionChangedDo: [ :selection | 
		self 
			transmitWith: aTransmission 
			value: (self applyTransform: selection transmission) ]
]
