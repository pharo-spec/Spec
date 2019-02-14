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
MorphicLabelAdapterTest >> testEmphasisBold [
	presenter emphasis: #bold.
	presenter buildWithSpec.
	self assert: presenter adapter widget font emphasis equals: 1
]

{ #category : #tests }
MorphicLabelAdapterTest >> testEmphasisItalic [
	presenter emphasis: #italic.
	self assert: presenter adapter widget font emphasis equals: 2
]

{ #category : #tests }
MorphicLabelAdapterTest >> testEmphasisMultiple [
	presenter emphasis: #(bold italic).
	self assert: presenter adapter widget font emphasis equals: 3
]

{ #category : #tests }
MorphicLabelAdapterTest >> testEmphasisNone [
	self assert: presenter adapter widget font emphasis equals: 0
]

{ #category : #tests }
MorphicLabelAdapterTest >> testSetLabelInPresenterSetsInInMorph [
	presenter label: 'something'.
	self assert: presenter adapter widget contents equals: 'something'
]
