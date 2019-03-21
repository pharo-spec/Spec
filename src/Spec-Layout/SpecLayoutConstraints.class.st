Class {
	#name : #SpecLayoutConstraints,
	#superclass : #Object,
	#instVars : [
		'spec',
		'layout'
	],
	#category : #'Spec-Layout-Base'
}

{ #category : #initialization }
SpecLayoutConstraints >> initialize [ 

	super initialize.
	self spec: #defaultSpec
]

{ #category : #accessing }
SpecLayoutConstraints >> layout [
	^ layout
]

{ #category : #accessing }
SpecLayoutConstraints >> layout: anObject [
	layout := anObject
]

{ #category : #accessing }
SpecLayoutConstraints >> spec [
	^ spec
]

{ #category : #accessing }
SpecLayoutConstraints >> spec: anObject [
	spec := anObject
]
