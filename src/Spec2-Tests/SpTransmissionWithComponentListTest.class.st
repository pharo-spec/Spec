Class {
	#name : 'SpTransmissionWithComponentListTest',
	#superclass : 'SpSmokeTest',
	#category : 'Spec2-Tests-Examples',
	#package : 'Spec2-Tests',
	#tag : 'Examples'
}

{ #category : 'accessing' }
SpTransmissionWithComponentListTest >> classToTest [

	^ SpComplexComponentListExample
]

{ #category : 'running' }
SpTransmissionWithComponentListTest >> setUp [

	super setUp.
	presenter := SpComplexComponentListExample new.

]

{ #category : 'running' }
SpTransmissionWithComponentListTest >> tearDown [ 

	presenter delete.
	super tearDown.
]

{ #category : 'tests' }
SpTransmissionWithComponentListTest >> testOpen [

	self shouldnt: [ presenter open ] raise: MessageNotUnderstood.
]
