Class {
	#name : #SpSingleSelectionMode,
	#superclass : #SpAbstractSelectionMode,
	#instVars : [
		'#selectedIndex => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #adding }
SpSingleSelectionMode >> addSubscription: aSubscription [
	^ (self announcerOfProperty: #selectedIndex) basicSubscribe: aSubscription
]

{ #category : #selecting }
SpSingleSelectionMode >> basicSelectIndex: indexToSelect [
	selectedIndex := indexToSelect
]

{ #category : #testing }
SpSingleSelectionMode >> includesIndex: anIndex [
	^ self selectedIndex = anIndex
]

{ #category : #testing }
SpSingleSelectionMode >> includesItem: anItem [

	^ self selectedItem = anItem
]

{ #category : #initialization }
SpSingleSelectionMode >> initialize [
	super initialize.
	selectedIndex := 0
]

{ #category : #testing }
SpSingleSelectionMode >> isEmpty [
	
	^ self selectedIndex = 0
]

{ #category : #selecting }
SpSingleSelectionMode >> selectAll [

	"Do nothing"
]

{ #category : #selecting }
SpSingleSelectionMode >> selectIndexes: aCollection [

	aCollection ifEmpty: [ ^ self unselectAll ].
	self selectIndex: aCollection first.
]

{ #category : #selecting }
SpSingleSelectionMode >> selectItems: aCollection [

	aCollection ifEmpty: [ ^ self unselectAll ].
	self selectItem: aCollection first.
]

{ #category : #selecting }
SpSingleSelectionMode >> selectedIndex [
	^ selectedIndex
]

{ #category : #selecting }
SpSingleSelectionMode >> selectedIndexes [
	"This provides polymorphism with sibling classes, and answers an array with a single 
	 element."
		
	^ self isEmpty
		ifTrue: [ #() ]
		ifFalse: [ { self selectedIndex } ]
]

{ #category : #selecting }
SpSingleSelectionMode >> selectedItem [

	self selectedIndex = 0 ifTrue: [ ^ nil ].
	^ self model at: self selectedIndex
]

{ #category : #selecting }
SpSingleSelectionMode >> selectedItems [
	
	^ self selectedItem
		ifNotNil: [ :anItem | { anItem } ]
		ifNil: [ #() ]
]

{ #category : #accessing }
SpSingleSelectionMode >> subscriptions [
	^ (self announcerOfProperty: #selectedIndex) subscriptions subscriptions
]

{ #category : #selecting }
SpSingleSelectionMode >> unselectAll [
	
	self selectIndex: 0
]

{ #category : #selecting }
SpSingleSelectionMode >> unselectIndex: anInteger [
	self selectedIndex = anInteger ifTrue: [ self basicSelectIndex: 0 ]
]

{ #category : #events }
SpSingleSelectionMode >> whenChangedDo: aBlockClosure [
	self property: #selectedIndex whenChangedDo: [ aBlockClosure cull: self ]
]
