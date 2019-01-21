Class {
	#name : #SelectionPresenterPort,
	#superclass : #OutputPresenterPort,
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
SelectionPresenterPort class >> portName [
	
	^ #selection
]

{ #category : #'as yet unclassified' }
SelectionPresenterPort >> attachTransmission: aTransmission [

	self presenter whenSelectedItemChanged: [ :selection | 
		aTransmission toPort
			incomingTransmission: (aTransmission transformed: selection)
			from: self ]
]
