Class {
	#name : #MorphicAdapterTestCase,
	#superclass : #SpecTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #running }
MorphicAdapterTestCase >> adapter [

	^ presenter adapter
]
