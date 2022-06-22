"
# Model Output Port

A **model output port** defines an outgoing transmission triggered by a change of the presenter model.

"
Class {
	#name : #SpModelChangedPort,
	#superclass : #SpOutputPort,
	#category : #'Spec2-Transmission-Base'
}

{ #category : #accessing }
SpModelChangedPort class >> portName [
	
	^ #model
]

{ #category : #attaching }
SpModelChangedPort >> attachTransmission: aTransmission to: aPresenter [
		
	aPresenter announcingObject whenChangedDo: [ :model | 
		self 
			transmitWith: aTransmission 
			value: (self applyTransform: model) ]
]
