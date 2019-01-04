Class {
	#name : #ProgressBarFixed,
	#superclass : #ProgressBarState,
	#instVars : [
		'valueHolder'
	],
	#category : #'Spec-Core-Widgets-Utils'
}

{ #category : #'instance creation' }
ProgressBarFixed class >> value: aNumber [
	^ self new
		value: aNumber;
		yourself
]

{ #category : #initialization }
ProgressBarFixed >> initialize [
	super initialize.
	valueHolder := 0 asValueHolder
]

{ #category : #accessing }
ProgressBarFixed >> value [
	^ valueHolder value
]

{ #category : #accessing }
ProgressBarFixed >> value: aNumber [
	valueHolder value: aNumber
]

{ #category : #enumerating }
ProgressBarFixed >> whenValueChangedDo: aBlock [
	valueHolder whenChangedDo: aBlock
]
