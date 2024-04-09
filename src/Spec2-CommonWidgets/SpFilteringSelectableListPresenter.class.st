"
A presenter to show a list that can be filter, and which elements are selectable.
"
Class {
	#name : 'SpFilteringSelectableListPresenter',
	#superclass : 'SpFilteringListPresenter',
	#instVars : [
		'selectColumn',
		'displayBlock',
		'displayIconBlock',
		'selectedItems',
		'previousSelectedIndex',
		'onActivation',
		'onDeactivation'
	],
	#category : 'Spec2-CommonWidgets-Core',
	#package : 'Spec2-CommonWidgets',
	#tag : 'Core'
}

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

	selectedItems remove: anObject.
	
	self onDeactivation ifNotNil: [ :valuable | valuable cull: anObject ]
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> display [

	^ displayBlock
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> display: aBlock [

	displayBlock := aBlock.
	listPresenter columns: self listColumns
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> displayIcon: aBlock [

	displayIconBlock := aBlock.
	listPresenter columns: self listColumns
]

{ #category : 'initialization' }
SpFilteringSelectableListPresenter >> initialize [

	selectedItems := Set new.
	displayBlock := [ :anObject | anObject asString ].
	super initialize
]

{ #category : 'initialization' }
SpFilteringSelectableListPresenter >> initializePresenters [

	super initializePresenters.
	listPresenter
		bindKeyCombination: Character space
		toAction: [ self toggleSelection ].

	listPresenter selection whenSelectedIndexChangedDo: [ 
		:newIndex 
		:prevIndex | previousSelectedIndex := prevIndex ].

	listPresenter eventHandler whenMouseDownDo: [ :event | 
		event shiftPressed
			ifTrue: [ 
				self
					selectFrom: previousSelectedIndex
					to: listPresenter selection selectedIndex ]
			ifFalse: [ self toggleSelection ] ].

	listPresenter
		bindKeyCombination: $a meta
		toAction: [ self activateAll ]
]

{ #category : 'api' }
SpFilteringSelectableListPresenter >> items: aCollection [
	"If the items are changing, we need to remove the items that are not present anymore from the collection."

	super items: aCollection.
	self selectedItems: (selectedItems select: [ :item | aCollection includes: item ])
]

{ #category : 'private' }
SpFilteringSelectableListPresenter >> listColumns [
	| column |

	column := SpCompositeTableColumn new.
	
	column addColumn: (selectColumn := (SpCheckBoxTableColumn new
		evaluated: [ :anObject | selectedItems includes: anObject ];
		onActivation: [ :anObject | self activateItem: anObject ];
		onDeactivation: [ :anObject |self deactivateItem: anObject ];
		beNotExpandable)).
		
	displayIconBlock ifNotNil: [
		column addColumn: (SpImageTableColumn evaluated: displayIconBlock) beNotExpandable ].
	
	column addColumn: (SpStringTableColumn evaluated: self display).

	^ { column }
]

{ #category : 'initialization' }
SpFilteringSelectableListPresenter >> newListToFilter [
	| table |
	
	table := self newTable. 
	table hideColumnHeaders.
	table columns: self listColumns.
	^ table
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

{ #category : 'accessing' }
SpFilteringSelectableListPresenter >> selectedItems: anObject [
	selectedItems := anObject
]

{ #category : 'private' }
SpFilteringSelectableListPresenter >> toggleSelection [

	| selectedItem |
	selectedItem := listPresenter selectedItem.
	(selectedItems includes: selectedItem)
		ifTrue: [ self deactivateItem: selectedItem ]
		ifFalse: [ self activateItem: selectedItem ].
	listPresenter refresh
]
