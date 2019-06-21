"
AbstractSpecLayoutAction is an abstract class representing a spec layout action.
"
Class {
	#name : #SpAbstractSpecLayoutAction,
	#superclass : #Object,
	#instVars : [
		'selector'
	],
	#category : #'Spec-Layout-Actions'
}

{ #category : #accesing }
SpAbstractSpecLayoutAction >> arguments [
	^ self subclassResponsibility
]

{ #category : #protocol }
SpAbstractSpecLayoutAction >> asSpecElements [
	^ {self selector} , self arguments
]

{ #category : #accesing }
SpAbstractSpecLayoutAction >> selector [
	^ selector
]

{ #category : #accesing }
SpAbstractSpecLayoutAction >> selector: anObject [
	selector := anObject
]
