"
I am raised when a window has been built
"
Class {
	#name : #WindowBuilt,
	#superclass : #Announcement,
	#instVars : [
		'model',
		'window'
	],
	#category : #'Spec-Core-Support'
}

{ #category : #accessing }
WindowBuilt >> model [ 

	^ model
]

{ #category : #accessing }
WindowBuilt >> model: aModel [

	model := aModel
]

{ #category : #accessing }
WindowBuilt >> window [

	^ window
]

{ #category : #accessing }
WindowBuilt >> window: aWindow [

	window := aWindow
]
