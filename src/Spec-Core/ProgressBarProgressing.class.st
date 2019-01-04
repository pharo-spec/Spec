Class {
	#name : #ProgressBarProgressing,
	#superclass : #ProgressBarState,
	#instVars : [
		'progressionBlock',
		'refreshDelay',
		'currentValueHolder'
	],
	#category : #'Spec-Core-Widgets-Utils'
}

{ #category : #'instance creation' }
ProgressBarProgressing class >> progression: aBlock every: aDelay [
	^ self new
		progressionBlock: aBlock;
		refreshDelay: aDelay;
		yourself
]

{ #category : #accessing }
ProgressBarProgressing >> currentValue [
	^ currentValueHolder value
]

{ #category : #accessing }
ProgressBarProgressing >> currentValue: aNumber [
	currentValueHolder value: aNumber
]

{ #category : #initialization }
ProgressBarProgressing >> initialize [
	super initialize.
	currentValueHolder := 0 asValueHolder
]

{ #category : #accessing }
ProgressBarProgressing >> progressionBlock [
	^ progressionBlock
]

{ #category : #accessing }
ProgressBarProgressing >> progressionBlock: anObject [
	progressionBlock := anObject
]

{ #category : #accessing }
ProgressBarProgressing >> refreshDelay [
	^ refreshDelay
]

{ #category : #accessing }
ProgressBarProgressing >> refreshDelay: anObject [
	refreshDelay := anObject
]

{ #category : #enumerating }
ProgressBarProgressing >> whenValueChangedDo: aBlock [
	currentValueHolder whenChangedDo: aBlock
]
