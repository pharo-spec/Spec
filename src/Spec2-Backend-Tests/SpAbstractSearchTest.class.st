Class {
	#name : #SpAbstractSearchTest,
	#superclass : #SpAbstractWidgetAdapterTest,
	#category : #'Spec2-Backend-Tests'
}

{ #category : #testing }
SpAbstractSearchTest class >> isAbstract [

	^ self == SpAbstractSearchTest
]

{ #category : #running }
SpAbstractSearchTest >> initializeTestedInstance [ 

	presenter items: #(10 20 30).
]

{ #category : #tests }
SpAbstractSearchTest >> testTypePerformsSearch [

	self presenter selection selectIndex: 1. "10"
	self adapter type: '2'. 
	self 
		assert: self presenter selection selectedIndex 
		equals: 2 "20"
]
