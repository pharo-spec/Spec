Class {
	#name : #ItemsPresenterPort,
	#superclass : #InputPresenterPort,
	#category : #'Spec-Core-Base'
}

{ #category : #'as yet unclassified' }
ItemsPresenterPort >> incomingTransmission: anObject from: outPort [

	self presenter items: anObject
]
