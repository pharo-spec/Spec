Class {
	#name : #SpecAbstractSelectionMode,
	#superclass : #Object,
	#instVars : [
		'widget'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #'instance creation' }
SpecAbstractSelectionMode class >> on: aWidget [

	^ self new
		widget: aWidget;
		yourself
]

{ #category : #selecting }
SpecAbstractSelectionMode >> basicSelectIndex: indexToSelect [

	self subclassResponsibility
]

{ #category : #testing }
SpecAbstractSelectionMode >> includesIndex: anIndex [

	self subclassResponsibility
]

{ #category : #testing }
SpecAbstractSelectionMode >> includesItem: anItem [

	self subclassResponsibility
]

{ #category : #testing }
SpecAbstractSelectionMode >> isEmpty [
	
	^ self selectedIndex = 0
]

{ #category : #testing }
SpecAbstractSelectionMode >> isMultipleSelection [
	
	^ false
]

{ #category : #accessing }
SpecAbstractSelectionMode >> model [
	^ widget model
]

{ #category : #selection }
SpecAbstractSelectionMode >> selectAll [

	^ self subclassResponsibility
]

{ #category : #selecting }
SpecAbstractSelectionMode >> selectIndex: anIndex [
	
	| indexToSelect |
	indexToSelect := anIndex.
	self model
		at: indexToSelect
		ifAbsent: [ indexToSelect := 0 ].

	self basicSelectIndex: indexToSelect
]

{ #category : #selecting }
SpecAbstractSelectionMode >> selectItem: anItem [
	
	| indexToSelect |
	indexToSelect := self model
		indexOf: anItem
		ifAbsent: [ 0 ].
	
	self basicSelectIndex: indexToSelect
]

{ #category : #selection }
SpecAbstractSelectionMode >> unselectAll [
	
	self subclassResponsibility
]

{ #category : #events }
SpecAbstractSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	self subclassResponsibility
]

{ #category : #accessing }
SpecAbstractSelectionMode >> widget [
	^ widget
]

{ #category : #accessing }
SpecAbstractSelectionMode >> widget: anObject [
	widget := anObject
]
