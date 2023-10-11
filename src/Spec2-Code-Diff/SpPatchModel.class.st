Class {
	#name : 'SpPatchModel',
	#superclass : 'Object',
	#instVars : [
		'source',
		'destination'
	],
	#category : 'Spec2-Code-Diff',
	#package : 'Spec2-Code-Diff'
}

{ #category : 'instance creation' }
SpPatchModel class >> newFrom: aSource to: aDestination [

	^ self new 
		from: aSource 
		to: aDestination
]

{ #category : 'accessing' }
SpPatchModel >> destination [

	^ destination ifNil: [ '' ]
]

{ #category : 'initialization' }
SpPatchModel >> from: aSource to: aDestination [

	source := aSource.
	destination := aDestination
]

{ #category : 'testing' }
SpPatchModel >> isEmpty [

	^ self source isEmpty 
		and: [ self destination isEmpty ] 
		
]

{ #category : 'accessing' }
SpPatchModel >> patch [

	^ DiffBuilder 
		buildPatchFrom: self source lines
		to: self destination lines
]

{ #category : 'accessing' }
SpPatchModel >> source [

	^ source ifNil: [ '' ]
]
