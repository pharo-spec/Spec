"
I'm a selection transmission. 
I will handle the transmission when a presenter can be selected (e.g. lists).
"
Class {
	#name : #ListSelectionPresenterPort,
	#superclass : #OutputPresenterPort,
	#category : #'Spec-Transmission'
}

{ #category : #accessing }
ListSelectionPresenterPort class >> portName [
	
	^ #selection
]

{ #category : #attaching }
ListSelectionPresenterPort >> attachTransmission: aTransmission [

	self destinationPresenter whenSelectionChangedDo: [ :selection | 
		self 
			transmitWith: aTransmission 
			value: selection selectedItem ]
]
