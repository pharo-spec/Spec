Class {
	#name : 'SpPatchMark',
	#superclass : 'Object',
	#instVars : [
		'name',
		'backgroundColor',
		'iconName'
	],
	#category : 'Spec2-Code-Diff',
	#package : 'Spec2-Code-Diff'
}

{ #category : 'instance creation' }
SpPatchMark class >> newName: aString [

	^ self new 
		name: aString; 
		yourself
]

{ #category : 'accessing' }
SpPatchMark >> backgroundColor [

	^ backgroundColor
]

{ #category : 'accessing' }
SpPatchMark >> backgroundColor: anObject [

	backgroundColor := anObject
]

{ #category : 'accessing' }
SpPatchMark >> iconName [

	^ iconName
]

{ #category : 'accessing' }
SpPatchMark >> iconName: anObject [

	iconName := anObject
]

{ #category : 'accessing' }
SpPatchMark >> name [

	^ name
]

{ #category : 'private' }
SpPatchMark >> name: anObject [

	name := anObject
]
