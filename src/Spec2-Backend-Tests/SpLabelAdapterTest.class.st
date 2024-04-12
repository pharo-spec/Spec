"
SUnit tests for MorphicLabelAdapter
"
Class {
	#name : 'SpLabelAdapterTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpLabelAdapterTest >> classToTest [
	^ SpLabelPresenter
]

{ #category : 'tests' }
SpLabelAdapterTest >> testSetLabelInPresenterAffectsWidget [
	presenter label: 'something'.
	self assert: self adapter label equals: 'something'
]
