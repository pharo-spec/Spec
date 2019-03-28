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
			aTransmission toPort
				incomingTransmission: (aTransmission transformed: selection selectedItem model)
				from: self.
			aTransmission applyPostTransmission ]
]
