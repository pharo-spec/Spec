"
I'm a selection transmission specific of a drop-list.
I will handle the transmission when an item is selected on a drop list.
"
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
