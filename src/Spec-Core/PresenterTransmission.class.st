"
A presenter transmission modelates a transmission from one output port to an input port.
A transmission is a way to handle how a presenter will handle input/output by default.

It uses ""ports"" to define how data passes, but it can also transform it (see #transform:) to make it pass in a correct way.
"
Class {
	#name : #PresenterTransmission,
	#superclass : #Object,
	#instVars : [
		'presenter',
		'fromPort',
		'toPort',
		'transformBlock',
		'postTransmission'
	],
	#category : #'Spec-Core-Transmission'
}

{ #category : #'instance creation' }
PresenterTransmission class >> on: aPresenter [

	^ self basicNew 
		initializePresenter: aPresenter;
		yourself
]

{ #category : #actions }
PresenterTransmission >> apply [
	fromPort attachTransmission: self
]

{ #category : #actions }
PresenterTransmission >> applyPostTransmission [
	self postTransmission ifNil: [ ^ self ].

	self postTransmission cull: self fromPresenter cull: self toPresenter
]

{ #category : #script }
PresenterTransmission >> from: aPresenter [
	self fromPort: aPresenter outputPortDefault
]

{ #category : #script }
PresenterTransmission >> from: aPresenter port: aSymbol [
	self fromPort: (aPresenter outputPortNamed: aSymbol)
]

{ #category : #actions }
PresenterTransmission >> from: aPresenter to: anotherPresenter transform: aValuable [
	self
		from: aPresenter
		to: anotherPresenter
		transform: aValuable
		postTransmission: nil
]

{ #category : #actions }
PresenterTransmission >> from: aPresenter to: anotherPresenter transform: aValuable postTransmission: anotherValuable [
	self
		from: aPresenter;
		to: anotherPresenter;
		transform: aValuable;
		postTransmission: anotherValuable;
		apply
]

{ #category : #accessing }
PresenterTransmission >> fromPort [

	^ fromPort
]

{ #category : #private }
PresenterTransmission >> fromPort: aPort [
	fromPort := aPort
]

{ #category : #private }
PresenterTransmission >> fromPresenter [
	^ self fromPort presenter
]

{ #category : #initialization }
PresenterTransmission >> initializePresenter: aPresenter [

	self initialize.
	presenter := aPresenter
]

{ #category : #accessing }
PresenterTransmission >> postTransmission [
	^ postTransmission
]

{ #category : #accessing }
PresenterTransmission >> postTransmission: aValuable [
	postTransmission := aValuable
]

{ #category : #private }
PresenterTransmission >> presenter [

	^ presenter
]

{ #category : #script }
PresenterTransmission >> to: aPresenter [

	self toPort: aPresenter inputPortDefault
]

{ #category : #script }
PresenterTransmission >> to: aPresenter port: aSymbol [

	self toPort: (aPresenter inputPortNamed: aSymbol)
]

{ #category : #accessing }
PresenterTransmission >> toPort [

	^ toPort
]

{ #category : #private }
PresenterTransmission >> toPort: aPort [
	toPort := aPort
]

{ #category : #private }
PresenterTransmission >> toPresenter [
	^ self toPort presenter
]

{ #category : #script }
PresenterTransmission >> transform: aBlock [

	transformBlock := aBlock
]

{ #category : #accessing }
PresenterTransmission >> transformed: anObject [ 

	transformBlock ifNil: [ ^ anObject ].
	^ transformBlock value: anObject
]
