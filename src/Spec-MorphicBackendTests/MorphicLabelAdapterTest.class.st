"
SUnit tests for MorphicLabelAdapter
"
Class {
	#name : #MorphicLabelAdapterTest,
	#superclass : #MorphicAdapterTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #accessing }
MorphicLabelAdapterTest >> classToTest [
	^ LabelPresenter
]

{ #category : #accessing }
MorphicLabelAdapterTest >> setUp [

	super setUp.
	presenter buildWithSpec
]

{ #category : #tests }
MorphicLabelAdapterTest >> testSetLabelInPresenterSetsInInMorph [
	presenter label: 'something'.
	self assert: presenter adapter widget contents equals: 'something'
]
