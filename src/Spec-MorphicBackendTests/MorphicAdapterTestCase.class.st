Class {
	#name : #MorphicAdapterTestCase,
	#superclass : #SpecTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #testing }
MorphicAdapterTestCase class >> isAbstract [ 
	^ self == MorphicAdapterTestCase
]

{ #category : #running }
MorphicAdapterTestCase >> adapter [

	^ presenter adapter
]
