Class {
	#name : #DropListSelectionPresenterPort,
	#superclass : #OutputPresenterPort,
	#category : #'Spec-Core-Transmission'
}

{ #category : #accessing }
DropListSelectionPresenterPort class >> portName [
	
	^ #selection
]

{ #category : #attaching }
DropListSelectionPresenterPort >> attachTransmission: aTransmission [
	self presenter
		whenSelectionChangedDo: [ :selection | 
			| transmitted |
			transmitted := selection selectedItem model.
			aTransmission toPort
				incomingTransmission: (aTransmission transformed: transmitted)
				from: self.
			aTransmission applyPostTransmissionWith: transmitted ]
]
