Class {
	#name : #MorphicCheckboxAdapterTest,
	#superclass : #MorphicAdapterTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #running }
MorphicCheckboxAdapterTest >> classToTest [

	^ CheckBoxPresenter
]

{ #category : #utils }
MorphicCheckboxAdapterTest >> emulateCenterClick [

	self emulateClick: MouseButtonEvent blueButton
]

{ #category : #utils }
MorphicCheckboxAdapterTest >> emulateClick: mouseButtonCode [
	presenter adapter widget toggleSelected
]

{ #category : #utils }
MorphicCheckboxAdapterTest >> emulateLeftClick [

	self emulateClick: MouseButtonEvent redButton
]

{ #category : #utils }
MorphicCheckboxAdapterTest >> emulateRightClick [

	self emulateClick: MouseButtonEvent yellowButton
]

{ #category : #running }
MorphicCheckboxAdapterTest >> testActivatedCheckboxPresenterStartsActivatedCheckboxMorph [

	presenter state: true.
	self openInstance.	
	
	self assert: self widget buttonMorph state equals: #on
]

{ #category : #running }
MorphicCheckboxAdapterTest >> testChangeActivatedAfterOpenCheckboxDectivatesIt [

	presenter state: false.
	self openInstance.	
	presenter state: true.
	self assert: presenter state
]

{ #category : #running }
MorphicCheckboxAdapterTest >> testChangeDeactivatedAfterOpenCheckboxDectivatesIt [

	presenter state: true.
	self openInstance.	
	presenter state: false.
	self deny: presenter state
]

{ #category : #running }
MorphicCheckboxAdapterTest >> testChangingLabelAffectTheWidget [
	
	presenter label: 'ALabel'.

	self openInstance.

	self assert: presenter adapter widget label equals: 'ALabel'
]

{ #category : #running }
MorphicCheckboxAdapterTest >> testChangingLabelAffectTheWidgetAfterOpen [
	
	self openInstance.

	presenter label: 'ALabel'.

	self assert: presenter adapter widget label equals: 'ALabel'
]

{ #category : #running }
MorphicCheckboxAdapterTest >> testClickActivatedCheckboxDectivatesIt [

	presenter state: true.
	self openInstance.	
	self emulateLeftClick.
	self deny: presenter state
]

{ #category : #running }
MorphicCheckboxAdapterTest >> testClickDeactivatedCheckboxActivatesIt [

	presenter state: false.
	self openInstance.	
	self emulateLeftClick.

	self assert: presenter state
]

{ #category : #running }
MorphicCheckboxAdapterTest >> testClickRaisesChangedEvent [

	| activated |
	activated := false.
	presenter whenChangedDo: [ activated := true ].
	self openInstance.	
	self emulateLeftClick.

	self assert: activated
]

{ #category : #running }
MorphicCheckboxAdapterTest >> testDeactivatedCheckboxPresenterStartsDeactivatedCheckboxMorph [

	presenter state: false.
	self openInstance.	
	
	self assert: self widget buttonMorph state equals: #off
]
