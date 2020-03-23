Class {
	#name : #SpWindowWillClose,
	#superclass : #Announcement,
	#instVars : [
		'window'
	],
	#category : #'Spec2-Core-Support'
}

{ #category : #accessing }
SpWindowWillClose >> window [
	^ window
]

{ #category : #accessing }
SpWindowWillClose >> window: anObject [
	window := anObject
]
