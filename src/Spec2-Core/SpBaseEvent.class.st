Class {
	#name : #SpBaseEvent,
	#superclass : #Object,
	#instVars : [
		'action'
	],
	#category : #'Spec2-Core-Base-Event'
}

{ #category : #enumerating }
SpBaseEvent class >> do: aBlock [

	^ self new action: aBlock
]

{ #category : #accessing }
SpBaseEvent >> action [
	^ action
]

{ #category : #accessing }
SpBaseEvent >> action: anObject [
	action := anObject
]

{ #category : #installing }
SpBaseEvent >> installOn: anAdapter target: aWidget [

	self subclassResponsibility
]
