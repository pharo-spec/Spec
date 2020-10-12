Class {
	#name : #SpToolCommandTest,
	#superclass : #TestCase,
	#category : #'Spec2-Code-Tests'
}

{ #category : #testing }
SpToolCommandTest class >> isAbstract [

	^ self = SpToolCommandTest
]

{ #category : #tests }
SpToolCommandTest >> testExecute [

	self subclassResponsibility
]
