Class {
	#name : #SpecGridConstraints,
	#superclass : #SpecLayoutConstraints,
	#instVars : [
		'position',
		'span'
	],
	#category : #'Spec-Layout-Grid'
}

{ #category : #accessing }
SpecGridConstraints >> position [
	^ position
]

{ #category : #accessing }
SpecGridConstraints >> position: anObject [
	position := anObject
]

{ #category : #accessing }
SpecGridConstraints >> span [
	^ span
]

{ #category : #accessing }
SpecGridConstraints >> span: anObject [
	span := anObject
]
