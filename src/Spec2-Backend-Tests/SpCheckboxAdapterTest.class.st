Class {
	#name : 'SpCheckboxAdapterTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpCheckboxAdapterTest >> classToTest [

	^ SpCheckBoxPresenter
]

{ #category : 'tests' }
SpCheckboxAdapterTest >> testActivatedCheckboxPresenterStartsActivatedCheckboxMorph [

	presenter state: true.
	self assert: self adapter state
]

{ #category : 'tests' }
SpCheckboxAdapterTest >> testChangeActivatedAfterOpenCheckboxDectivatesIt [

	presenter state: false.
	
	"Force opening the spec instance here.
	We want to test that once open we can change the state"
	self openInstance.

	presenter state: true.
	self assert: presenter state
]

{ #category : 'tests' }
SpCheckboxAdapterTest >> testChangeDeactivatedAfterOpenCheckboxDectivatesIt [

	presenter state: true.
	
	"Force opening the spec instance here.
	We want to test that once open we can change the state"
	self openInstance.
	
	presenter state: false.
	self deny: presenter state
]

{ #category : 'tests' }
SpCheckboxAdapterTest >> testChangingLabelAffectTheWidget [
	
	presenter label: 'ALabel'.
	self assert: self adapter label equals: 'ALabel'
]

{ #category : 'tests' }
SpCheckboxAdapterTest >> testClickActivatedCheckboxDectivatesIt [

	presenter state: true.
	
	self emulateLeftClick.
	self deny: presenter state
]

{ #category : 'tests' }
SpCheckboxAdapterTest >> testClickDeactivatedCheckboxActivatesIt [

	presenter state: false.
	
	self emulateLeftClick.
	self assert: presenter state
]

{ #category : 'tests' }
SpCheckboxAdapterTest >> testClickRaisesChangedEvent [

	| activated |
	activated := false.
	presenter whenChangedDo: [ activated := true ].

	self emulateLeftClick.
	self assert: activated
]

{ #category : 'tests' }
SpCheckboxAdapterTest >> testDeactivatedCheckboxPresenterStartsDeactivatedCheckboxMorph [

	presenter state: false.
	self deny: self adapter state
]
