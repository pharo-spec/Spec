"
A SpecAbstractWidgetLayoutTest is a test class for testing the behavior of SpecAbstractWidgetLayout
"
Class {
	#name : #SpecAbstractWidgetLayoutTest,
	#superclass : #TestCase,
	#category : #'Spec-Tests-Layout'
}

{ #category : #test }
SpecAbstractWidgetLayoutTest >> testAdapterForBindings [
	| layout |
	layout := SpecAbstractWidgetLayout for: #ListAdapter.
	self assert: (layout adapterFor: ListPresenter new bindings: SpecStubAdapterBindings new) class equals: SpecStubListAdapter
]

{ #category : #test }
SpecAbstractWidgetLayoutTest >> testAdapterForBindingsRaiseErrorIfNoBinding [
	| layout |
	layout := SpecAbstractWidgetLayout for: #NonExistingAdapter.
	self should: [ layout adapterFor: ListPresenter new bindings: SpecStubAdapterBindings new ] raise: Error
]

{ #category : #test }
SpecAbstractWidgetLayoutTest >> testBuildAdapterForBindings [
	| layout |
	layout := SpecAbstractWidgetLayout for: #ListAdapter.
	self assert: (layout buildAdapterFor: ListPresenter new bindings: SpecStubAdapterBindings new) widget class equals: SpecStubListView
]
