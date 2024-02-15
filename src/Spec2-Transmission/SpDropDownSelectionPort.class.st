Class {
	#name : 'SpDropDownSelectionPort',
	#superclass : 'SpOutputPort',
	#category : 'Spec2-Transmission-Base',
	#package : 'Spec2-Transmission',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpDropDownSelectionPort class >> portName [
	
	^ #selection
]

{ #category : 'attaching' }
SpDropDownSelectionPort >> attachTransmission: aTransmission to: aPresenter [
	
	aPresenter whenSelectionChangedDo: [ :anObject | 
		self 
			transmitWith: aTransmission 
			value: (self applyTransform: anObject) ]
]
