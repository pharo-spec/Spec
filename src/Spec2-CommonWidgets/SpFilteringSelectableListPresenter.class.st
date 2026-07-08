"
A presenter to show a list that can be filter, and which elements are selectable.
"
Class {
	#name : 'SpFilteringSelectableListPresenter',
	#superclass : 'SpFilteringListPresenter',
	#instVars : [
		'selectedItems',
		'onActivation',
		'onDeactivation'
	],
	#category : 'Spec2-CommonWidgets-Core',
	#package : 'Spec2-CommonWidgets',
	#tag : 'Core'
}

{ #category : 'examples' }
SpFilteringSelectableListPresenter class >> example [
	<sampleInstance>

	^ self new
		items: Smalltalk allClassesAndTraits;
		open
]

{ #category : 'private' }
SpFilteringSelectableListPresenter >> activateAll [
	| itemsToSelect |
	
	itemsToSelect := self items \ selectedItems.
	itemsToSelect ifEmpty: [ ^ self ].

	self selectItems: self items.

	self onActivation ifNotNil: [ :valuable | 
		itemsToSelect do: [ :item | valuable cull: item ] ]		
]

{ #category : 'private' }
SpFilteringSelectableListPresenter >> activateItem: anObject [

	selectedItems add: anObject.
	
	self onActivation ifNotNil: [ :valuable | valuable cull: anObject ]
]

{ #category : 'private' }
SpFilteringSelectableListPresenter >> deactivateItem: anObject [

	selectedItems remove: anObject ifAbsent: [ ^ self ].
	
	self onDeactivation ifNotNil: [ :valuable | valuable cull: anObject ]
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> display [

	^ listPresenter display
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> display: aBlock [

	listPresenter display: aBlock
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> displayIcon: aBlock [

	listPresenter displayIcon: aBlock
]

{ #category : 'initialization' }
SpFilteringSelectableListPresenter >> initialize [

	selectedItems := Set new.
	super initialize
]

{ #category : 'initialization' }
SpFilteringSelectableListPresenter >> initializePresenters [

	super initializePresenters.
	
	listPresenter
		addShortcutWith: [ :action | action 
			shortcutKey: Character space asKeyCombination;
			action: [ self toggleSelection ] ];
		addShortcutWith: [ :action | action 
			shortcutKey: $a actionModifier;
			action: [ self activateAll ] ]
]

{ #category : 'private' }
SpFilteringSelectableListPresenter >> isActive: anItem [

	^ selectedItems includes: anItem
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> items: aCollection [
	"If the items are changing, we need to remove the items that are not present anymore from the collection."

	super items: aCollection.
	selectedItems := selectedItems select: [ :item | aCollection includes: item ]
]

{ #category : 'initialization' }
SpFilteringSelectableListPresenter >> newListToFilter [

	^ self newEasyListView
		rowPresenterClass: SpFilteredSelectableRowPresenter;
		whenRowPresenterInstantiatedDo: [ :aRowPresenter | 
			aRowPresenter stateProvider: self ];
		yourself
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> onActivation [

	^ onActivation
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> onActivation: aBlock [

	onActivation := aBlock
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> onDeactivation [

	^ onDeactivation
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> onDeactivation: aBlock [

	onDeactivation := aBlock
]

{ #category : 'private' }
SpFilteringSelectableListPresenter >> selectFrom: fromIndex to: toIndex [
	| newItems |
	
	newItems := fromIndex < toIndex
		ifTrue: [ listPresenter items copyFrom: fromIndex to: toIndex ]
		ifFalse: [ listPresenter items copyFrom: toIndex to: fromIndex ].
	
	selectedItems addAll: newItems.
	
	self onActivation ifNotNil: [ :valuable | 
		newItems do: [ :item | valuable cull: item ] ].
	
	listPresenter refresh
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> selectItem: anObject [

	self selectItems: (self selectedItems copyWith: anObject)
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> selectItems: aCollection [

	selectedItems := aCollection asSet.
	listPresenter selectItems: selectedItems asOrderedCollection
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> selectedItems [

	^ selectedItems sorted: [ :a :b | (self items indexOf: a) < (self items indexOf: b) ]
]

{ #category : 'private' }
SpFilteringSelectableListPresenter >> toggleSelection [
	| selectedItem |
	
	selectedItem := listPresenter selectedItem.
	(self isActive: selectedItem)
		ifTrue: [ self deactivateItem: selectedItem ]
		ifFalse: [ self activateItem: selectedItem ].
	"update just the one we need"
	listPresenter selectedRowPresenter updatePresenter 
]
