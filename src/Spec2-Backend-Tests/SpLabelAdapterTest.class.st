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
SpLabelAdapterTest >> testBackgroundColorChangesColor [
	"test this issue: https://github.com/pharo-spec/Spec/issues/1524"
	
	presenter label: 'Test'.
	presenter displayBackgroundColor: [ Color green ].
	self openInstance.
	self assert: self adapter widget backgroundColor equals: Color green
]

{ #category : 'tests' }
SpLabelAdapterTest >> testSetLabelInPresenterAffectsWidget [
	presenter label: 'something'.
	self assert: self adapter label equals: 'something'
]
