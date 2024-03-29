Class {
	#name : 'SpGridAxisConstraints',
	#superclass : 'Object',
	#traits : 'SpTAlignable',
	#classTraits : 'SpTAlignable classTrait',
	#instVars : [
		'expand'
	],
	#category : 'Spec2-Layout-Grid',
	#package : 'Spec2-Layout',
	#tag : 'Grid'
}

{ #category : 'accessing' }
SpGridAxisConstraints >> beExpand [ 

	self expand: true
]

{ #category : 'accessing' }
SpGridAxisConstraints >> beNotExpand [ 

	self expand: false
]

{ #category : 'private' }
SpGridAxisConstraints >> expand [
	^ expand
]

{ #category : 'private' }
SpGridAxisConstraints >> expand: anObject [
	expand := anObject
]

{ #category : 'testing' }
SpGridAxisConstraints >> isExpand [

	^ expand == true
]
