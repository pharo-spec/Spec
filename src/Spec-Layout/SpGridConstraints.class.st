Class {
	#name : #SpGridConstraints,
	#superclass : #SpLayoutConstraints,
	#instVars : [
		'position',
		'span'
	],
	#category : #'Spec-Layout-Grid'
}

{ #category : #'instance creation' }
SpGridConstraints class >> at: aPoint [

	^ self new 
		position: aPoint;
		yourself
]

{ #category : #'instance creation' }
SpGridConstraints class >> at: aPoint span: spanPoint [

	^ self new 
		position: aPoint;
		span: spanPoint;
		yourself
]

{ #category : #accessing }
SpGridConstraints >> column [

	^ self position x
]

{ #category : #accessing }
SpGridConstraints >> columnSpan [

	^ self span x
]

{ #category : #initialization }
SpGridConstraints >> initialize [

	super initialize.
	self position: 1@1.
	self span: 1@1
]

{ #category : #accessing }
SpGridConstraints >> position [
	^ position
]

{ #category : #accessing }
SpGridConstraints >> position: anObject [
	position := anObject
]

{ #category : #accessing }
SpGridConstraints >> row [

	^ self position y
]

{ #category : #accessing }
SpGridConstraints >> rowSpan [

	^ self span y
]

{ #category : #accessing }
SpGridConstraints >> span [
	^ span
]

{ #category : #accessing }
SpGridConstraints >> span: anObject [
	span := anObject
]
