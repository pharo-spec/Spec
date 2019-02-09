Class {
	#name : #SpecMultipleSelectionMode,
	#superclass : #SpecAbstractSelectionMode,
	#instVars : [
		'selectedIndexesValueHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #'as yet unclassified' }
SpecMultipleSelectionMode >> addSubscription: aSubscription [

	^ selectedIndexesValueHolder announcer basicSubscribe: aSubscription
]

{ #category : #selecting }
SpecMultipleSelectionMode >> basicSelectIndex: indexToSelect [

	"Adding to the selection an out of range should not change selection"
	indexToSelect = 0 ifTrue: [ ^ self ].

	selectedIndexesValueHolder value: (selectedIndexesValueHolder value copyWith: indexToSelect)
]

{ #category : #testing }
SpecMultipleSelectionMode >> includesIndex: anIndex [

	^ self selectedIndexes includes: anIndex
]

{ #category : #testing }
SpecMultipleSelectionMode >> includesItem: anItem [

	^ self selectedItems includes: anItem
]

{ #category : #selecting }
SpecMultipleSelectionMode >> initialize [

	super initialize.
	selectedIndexesValueHolder := OrderedCollection new asValueHolder
]

{ #category : #selecting }
SpecMultipleSelectionMode >> isEmpty [ 
	^ selectedIndexesValueHolder value isEmpty
]

{ #category : #testing }
SpecMultipleSelectionMode >> isMultipleSelection [
	
	^ true
]

{ #category : #selection }
SpecMultipleSelectionMode >> selectAll [
	
	self selectIndexes: (1 to: self model size)
]

{ #category : #accessing }
SpecMultipleSelectionMode >> selectIndexes: aCollection [

	1haltIf: [ aCollection includes: 0 ].
	^ selectedIndexesValueHolder value: aCollection asOrderedCollection
]

{ #category : #accessing }
SpecMultipleSelectionMode >> selectedIndexes [

	^ selectedIndexesValueHolder value
]

{ #category : #accessing }
SpecMultipleSelectionMode >> selectedItems [

	^ self selectedIndexes collect: [ :idx | self model at: idx ].
]

{ #category : #'as yet unclassified' }
SpecMultipleSelectionMode >> subscriptions [

	^ selectedIndexesValueHolder announcer subscriptions
]

{ #category : #selection }
SpecMultipleSelectionMode >> unselectAll [
	
	self selectIndexes: #()
]

{ #category : #events }
SpecMultipleSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	selectedIndexesValueHolder whenChangedDo: [ aBlockClosure value: self ]
]
