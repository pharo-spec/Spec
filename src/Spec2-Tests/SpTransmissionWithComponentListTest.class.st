Class {
	#name : 'SpTransmissionWithComponentListTest',
	#superclass : 'SpSmokeTest',
	#category : 'Spec2-Tests-Examples',
	#package : 'Spec2-Tests',
	#tag : 'Examples'
}

{ #category : 'accessing' }
SpTransmissionWithComponentListTest >> classToTest [

	^ SpComponentListSelectionExample
]

{ #category : 'running' }
SpTransmissionWithComponentListTest >> setUp [

	super setUp.
	presenter := SpComponentListSelectionExample new.

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

{ #category : 'tests' }
SpTransmissionWithComponentListTest >> testSelection [

	presenter selectorPresenter selectIndex: 1.
	self 
		assertCollection: presenter destinationPresenter items
		hasSameElements: #(10 20)
]
