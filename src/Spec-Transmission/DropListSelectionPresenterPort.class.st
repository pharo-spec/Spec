Class {
	#name : #DropListSelectionPresenterPort,
	#superclass : #OutputPresenterPort,
	#category : #'Spec-Transmission'
}

{ #category : #accessing }
DropListSelectionPresenterPort class >> portName [
	
	^ #selection
]

{ #category : #attaching }
DropListSelectionPresenterPort >> attachTransmission: aTransmission [
	
	self destinationPresenter whenSelectionChangedDo: [ :selection | 
		self 
			transmitWith: aTransmission 
			value: selection selectedItem model ]
]
