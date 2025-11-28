Class {
	#name : 'SpTreeSingleSelectionMode',
	#superclass : 'SpAbstractTreeSelectionMode',
	#category : 'Spec2-Core-Widgets-Tree',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Tree'
}

{ #category : 'selection' }
SpTreeSingleSelectionMode >> itemNotFoundAction [
	self clearSelection
]

{ #category : 'selecting' }
SpTreeSingleSelectionMode >> selectAll [
	"Do nothing, since single selection mode wont allow for selecting all elements."

	
]

{ #category : 'accessing' }
SpTreeSingleSelectionMode >> selectPath: aPath [
	"Check comment in my superclass to know how to use selectPath:"

	"If the path is out of range, keep the selection."

	| path |
	path := aPath asArray.
	path ifEmpty: [ ^ self unselectAll ].
	presenter itemAtPath: path ifAbsent: [ ^ self ].
	selection = path ifTrue: [ ^ self ].
	selection := path
]

{ #category : 'accessing' }
SpTreeSingleSelectionMode >> selectPaths: pathArray [

	self selectPath: (pathArray 
		ifNotEmpty: [ pathArray last ]
		ifEmpty: [ pathArray ])
]

{ #category : 'accessing' }
SpTreeSingleSelectionMode >> selectedItem [
	
	selection ifEmpty: [ ^ nil ].
	
	^ presenter itemAtPath: selection.
]

{ #category : 'accessing' }
SpTreeSingleSelectionMode >> selectedPath [
	
	^ selection
]

{ #category : 'accessing' }
SpTreeSingleSelectionMode >> selectedPaths [
	
	selection ifEmpty: [ ^ #() ].
	^ { selection }
]

{ #category : 'selecting' }
SpTreeSingleSelectionMode >> unselectPath: aPath [
	"If the path is out of range, keep the selection."
	selection = aPath ifFalse: [ ^ self ].
	self clearSelection
]
