Class {
	#name : 'SpLayoutConstraints',
	#superclass : 'Object',
	#instVars : [
		'spec'
	],
	#category : 'Spec2-Layout-Base',
	#package : 'Spec2-Layout',
	#tag : 'Base'
}

{ #category : 'initialization' }
SpLayoutConstraints >> initialize [ 

	super initialize.
	self spec: #defaultLayout
]

{ #category : 'accessing' }
SpLayoutConstraints >> spec [
	^ spec
]

{ #category : 'accessing' }
SpLayoutConstraints >> spec: anObject [
	spec := anObject
]
