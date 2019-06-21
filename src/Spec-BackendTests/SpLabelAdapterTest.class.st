"
SUnit tests for MorphicLabelAdapter
"
Class {
	#name : #SpLabelAdapterTest,
	#superclass : #SpAbstractWidgetAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #accessing }
SpLabelAdapterTest >> classToTest [
	^ SpLabelPresenter
]

{ #category : #tests }
SpLabelAdapterTest >> testSetLabelInPresenterSetsInInMorph [
	presenter label: 'something'.
	self assert: self adapter label equals: 'something'
]
