"
I define an input port to delegate incomming transmission to modify items of a list (or table) style presenters.
"
Class {
	#name : #ListItemsPresenterPort,
	#superclass : #InputPresenterPort,
	#category : #'Spec-Transmission'
}

{ #category : #accessing }
ListItemsPresenterPort class >> portName [

	^ #items
]

{ #category : #'handling transmission' }
ListItemsPresenterPort >> incomingTransmission: anObject from: outPort [

	self destinationPresenter items: anObject
]
