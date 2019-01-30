Class {
	#name : #PresenterTransmission,
	#superclass : #Object,
	#instVars : [
		'presenter',
		'fromPresenter',
		'toPresenter',
		'fromPort',
		'toPort',
		'transformBlock'
	],
	#category : #'Spec-Core-Base'
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

{ #category : #private }
PresenterTransmission >> basicFrom: aPresenter port: aPort [

	fromPresenter := aPresenter.
	fromPort := aPort
]

{ #category : #private }
PresenterTransmission >> basicFromPort: aPort [

	fromPort := aPort
]

{ #category : #private }
PresenterTransmission >> basicTo: aPresenter port: aPort [

	toPresenter := aPresenter.
	toPort := aPort
]

{ #category : #script }
PresenterTransmission >> from: aPresenter [

	self basicFrom: aPresenter port: aPresenter outputPortDefault
]

{ #category : #script }
PresenterTransmission >> from: aPresenter port: aSymbol [

	self basicFrom: aPresenter port: (aPresenter outputPortNamed: aSymbol)
]

{ #category : #accessing }
PresenterTransmission >> fromPort [

	^ fromPort
]

{ #category : #initialization }
PresenterTransmission >> initializePresenter: aPresenter [

	self initialize.
	presenter := aPresenter
]

{ #category : #private }
PresenterTransmission >> presenter [

	^ presenter
]

{ #category : #script }
PresenterTransmission >> to: aPresenter [

	self basicTo: aPresenter port: aPresenter inputPortDefault
]

{ #category : #script }
PresenterTransmission >> to: aPresenter port: aSymbol [

	self basicTo: aPresenter port: (aPresenter inputPortNamed: aSymbol)
]

{ #category : #accessing }
PresenterTransmission >> toPort [

	^ toPort
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
