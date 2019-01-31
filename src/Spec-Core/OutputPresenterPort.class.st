Class {
	#name : #OutputPresenterPort,
	#superclass : #PresenterPort,
	#category : #'Spec-Core-Base'
}

{ #category : #'as yet unclassified' }
OutputPresenterPort >> attachTransmission: aTransmission [ 
	"override this to add specific transmissions"

	self subclassResponsibility
]

{ #category : #testing }
OutputPresenterPort >> isOutput [

	^ true
]
