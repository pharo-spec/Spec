Class {
	#name : 'SpPropertyChangedPort',
	#superclass : 'SpOutputPort',
	#instVars : [
		'property'
	],
	#category : 'Spec2-Transmission-Base',
	#package : 'Spec2-Transmission',
	#tag : 'Base'
}

{ #category : 'instance creation' }
SpPropertyChangedPort class >> newPresenter: aPresenter property: aSymbol [

	^ self new
		presenter: aPresenter; 
		property: aSymbol;
		yourself
]

{ #category : 'instance creation' }
SpPropertyChangedPort class >> portName [
	
	^ #property
]

{ #category : 'attaching' }
SpPropertyChangedPort >> attachTransmission: aTransmission to: aPresenter [
		
	aPresenter property: self property whenChangedDo: [ :aValue | 
		self 
			transmitWith: aTransmission 
			value: (self applyTransform: aValue) ]
]

{ #category : 'accessing' }
SpPropertyChangedPort >> property [

	^ property
]

{ #category : 'accessing' }
SpPropertyChangedPort >> property: aSymbol [

	property := aSymbol
]
