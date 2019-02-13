Class {
	#name : #MorphicAdapterTestCase,
	#superclass : #SpecTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #running }
MorphicAdapterTestCase >> adapter [

	^ presenter adapter
]

{ #category : #running }
MorphicAdapterTestCase >> testChangingColorAffectTheWidget [
	
	presenter color: Color red.

	self openInstance.

	self assert: presenter adapter widget color equals: Color red
]
