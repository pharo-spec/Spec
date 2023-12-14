"
I am a fast table column to represent item in array at particular index.
 
Internal Representation and Key Implementation Points.

This class has and extends API of FTColumn

    Instance Variables
	id:			An id for the column
	width:		An Integer that represent the width of a column.
	index:		<Number>
"
Class {
	#name : 'SpFTArrayIndexColumn',
	#superclass : 'SpFTColumn',
	#instVars : [
		'index'
	],
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
SpFTArrayIndexColumn class >> index: aNumber [
	^ self new 
		index: aNumber
]

{ #category : 'instance creation' }
SpFTArrayIndexColumn class >> index: aNumber width: aNumber2 [
	^ (self index: aNumber) 
		width: aNumber2
]

{ #category : 'accessing' }
SpFTArrayIndexColumn >> index [
	^ index
]

{ #category : 'accessing' }
SpFTArrayIndexColumn >> index: anObject [
	index := anObject
]

{ #category : 'accessing' }
SpFTArrayIndexColumn >> transform: anArray [
	^ anArray at: self index
]
