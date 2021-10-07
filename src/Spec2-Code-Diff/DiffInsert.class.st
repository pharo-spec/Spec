Class {
	#name : #DiffInsert,
	#superclass : #DiffPatchElement,
	#instVars : [
		'newPosition'
	],
	#category : #'Spec2-Code-Diff'
}

{ #category : #'instance creation' }
DiffInsert class >> newOldPosition: oldNumber newPosition: newNumber [

	^ self new 
		oldPosition: oldNumber; 
		newPosition: newNumber
]

{ #category : #visiting }
DiffInsert >> accept: aVisitor [

	aVisitor visitInsert: self
]

{ #category : #testing }
DiffInsert >> isInsert [

	^ true
]

{ #category : #accessing }
DiffInsert >> newPosition [

	^ newPosition
]

{ #category : #accessing }
DiffInsert >> newPosition: anObject [

	newPosition := anObject
]

{ #category : #printing }
DiffInsert >> printPositionOn: stream [
	
	super printPositionOn: stream.
	stream << ', new='; print: self newPosition	
]
