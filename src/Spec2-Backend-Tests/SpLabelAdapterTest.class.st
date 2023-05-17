"
SUnit tests for MorphicLabelAdapter
"
Class {
	#name : #SpLabelAdapterTest,
	#superclass : #SpAbstractWidgetAdapterTest,
	#category : #'Spec2-Backend-Tests-Base'
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
