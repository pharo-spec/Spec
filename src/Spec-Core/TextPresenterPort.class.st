Class {
	#name : #TextPresenterPort,
	#superclass : #InputPresenterPort,
	#category : #'Spec-Core-Base'
}

{ #category : #'as yet unclassified' }
TextPresenterPort >> incomingTransmission: anObject from: outPort [

	self presenter text: anObject
]
