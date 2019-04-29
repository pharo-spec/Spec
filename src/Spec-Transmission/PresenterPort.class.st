"
I'm a base port.
"
Class {
	#name : #PresenterPort,
	#superclass : #Object,
	#instVars : [
		'name',
		'presenter',
		'delegation'
	],
	#category : #'Spec-Transmission'
}

{ #category : #'instance creation' }
PresenterPort class >> newDelegate: aBlock [ 

	^ self new 
		delegateTo: aBlock;
		yourself
]

{ #category : #'instance creation' }
PresenterPort class >> newName: aName [

	^ self new 
		name: aName;
		yourself
]

{ #category : #'instance creation' }
PresenterPort class >> newName: aName delegate: aBlock [ 

	^ self new 
		name: aName;
		delegateTo: aBlock;
		yourself
]

{ #category : #accessing }
PresenterPort class >> portName [

	^ self subclassResponsibility
]

{ #category : #accessing }
PresenterPort >> delegateTo: aPresenter [

	delegation := aPresenter
]

{ #category : #accessing }
PresenterPort >> destinationPresenter [

	^ delegation 
		ifNotNil: [ delegation value ]
		ifNil: [ presenter ]
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

	^ name ifNil: [ self class portName ]
]

{ #category : #accessing }
PresenterPort >> name: anObject [
	name := anObject
]

{ #category : #accessing }
PresenterPort >> presenter [ 

	^ presenter
]

{ #category : #accessing }
PresenterPort >> presenter: aPresenter [

	presenter := aPresenter
]
