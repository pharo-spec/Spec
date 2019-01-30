Class {
	#name : #InputPresenterPort,
	#superclass : #PresenterPort,
	#category : #'Spec-Core-Base'
}

{ #category : #'as yet unclassified' }
InputPresenterPort >> incomingTransmission: anObject from: outPort [

	self subclassResponsibility
]

{ #category : #testing }
InputPresenterPort >> isInput [ 

	^ true
]
