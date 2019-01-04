Class {
	#name : #ProgressBarState,
	#superclass : #Object,
	#category : #'Spec-Core-Widgets-Utils'
}

{ #category : #enumerating }
ProgressBarState >> whenValueChangedDo: aBlock [
	self subclassResponsibility
]
