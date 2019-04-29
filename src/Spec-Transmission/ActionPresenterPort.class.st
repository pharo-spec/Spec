"
An action name is a generic action to handle the result of a transmission.
It will execute a block when transmission arrives.

Example: 

aPresenter 
	transmitDo: [ :aValue | ... ]
	transform: #asString
"
Class {
	#name : #ActionPresenterPort,
	#superclass : #InputPresenterPort,
	#instVars : [
		'actionBlock'
	],
	#category : #'Spec-Transmission'
}

{ #category : #'instance creation' }
ActionPresenterPort class >> newAction: aBlock [

	^ self new
		action: aBlock;
		yourself
]

{ #category : #accessing }
ActionPresenterPort class >> portName [
	"An action block does not has a name"
	
	^ nil
]

{ #category : #accessing }
ActionPresenterPort >> action [ 

	^ actionBlock
]

{ #category : #accessing }
ActionPresenterPort >> action: aBlock [

	actionBlock := aBlock
]

{ #category : #'handling transmission' }
ActionPresenterPort >> incomingTransmission: anObject from: outPort [

	self action 
		cull: anObject
		cull: outPort 
]
