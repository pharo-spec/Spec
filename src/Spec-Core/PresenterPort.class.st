Class {
	#name : #PresenterPort,
	#superclass : #Object,
	#instVars : [
		'presenter'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #accessing }
PresenterPort class >> portName [

	^ self subclassResponsibility
]

{ #category : #testing }
PresenterPort >> isInput [ 

	^ false
]

{ #category : #testing }
PresenterPort >> isOutput [

	^ false
]

{ #category : #accessing }
PresenterPort >> name [

	^ self class portName
]

{ #category : #accessing }
PresenterPort >> presenter [ 

	^ presenter
]

{ #category : #accessing }
PresenterPort >> presenter: aPresenter [

	presenter := aPresenter
]
