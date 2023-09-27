"
Description
--------------------

I am a state of a ProgressBarPresenter managing the behavior of a fixed progress bar. I will have one value (between 0 and 1) and the progress will not change.

Examples
--------------------

	 ProgressBarFixed value: 0.1
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	valueHolder:		<aValueHolder> 		Value holder keeping the value I should be fixed on.

"
Class {
	#name : 'SpFixedProgressBarState',
	#superclass : 'SpProgressBarState',
	#instVars : [
		'value'
	],
	#category : 'Spec2-Core-Utils',
	#package : 'Spec2-Core',
	#tag : 'Utils'
}

{ #category : 'instance creation' }
SpFixedProgressBarState class >> value: aNumber [
	^ self new
		value: aNumber;
		yourself
]

{ #category : 'initialization' }
SpFixedProgressBarState >> initialize [
	
	self class initializeSlots: self.
	super initialize.
	value := 0
]

{ #category : 'accessing' }
SpFixedProgressBarState >> value [
	^ value
]

{ #category : 'accessing' }
SpFixedProgressBarState >> value: aNumber [
	value := aNumber
]

{ #category : 'api - events' }
SpFixedProgressBarState >> whenValueChangedDo: aBlock [
	self property: #value whenChangedDo: aBlock
]
