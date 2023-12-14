Class {
	#name : 'SpCodeStyleForTest',
	#superclass : 'Object',
	#instVars : [
		'foreground'
	],
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'comparing' }
SpCodeStyleForTest >> = aTag [ 

	^ self foreground = aTag foreground
]

{ #category : 'accessing' }
SpCodeStyleForTest >> foreground [
	^ foreground
]

{ #category : 'accessing' }
SpCodeStyleForTest >> foreground: anObject [
	foreground := anObject
]
