"
A presenter to display dropdown lists.

_NOTE: I assume there is a little problem on an empty list, but frankly, who creates an empty drop list?_

"
Class {
	#name : 'SpDropListPresenter',
	#superclass : 'SpAbstractWidgetPresenter',
	#instVars : [
		'#model => ObservableSlot',
		'#startsWithSelection',
		'#selection',
		'#displayBlock => ObservableSlot',
		'#iconBlock => ObservableSlot'
	],
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'specs' }
SpDropListPresenter class >> adapterName [

	^ #DropListAdapter
]

{ #category : 'documentation' }
SpDropListPresenter class >> documentFactoryMethodSelector [

	^ #newDropList
]

{ #category : 'specs' }
SpDropListPresenter class >> title [

	^ 'Drop List'
]

{ #category : 'api' }
SpDropListPresenter >> addItemLabeled: aString do: aBlock [
	"Add an item to the drop list, along with an action.
	 `aString` is the label of the element.
	 `aBlock` is the action asociated to this element. It receives zero arguments."
	
	self deprecated: 'This accessor introduces a wrong way to handle models (since it exposes an internal mechanism to the user. To use correctly this component, you need to follow a different pattent, e.g. what you can find in the examples section in class side of this presenter. Note that you can use SpDropListItem elements as model if you want to replicate the mechanism.'.
	self addItemLabeled: aString do: aBlock icon: nil.
]

{ #category : 'api' }
SpDropListPresenter >> addItemLabeled: aString do: aBlock icon: anIcon [
	"Add an item to the drop list, along with an icon and an action.
	 `aString` is the label of the element.
	 `aBlock` is the action asociated to this element. It receives zero arguments.
	 `anIcon` is the icon (an instance of `Form`) to be shown."
	| item |

	self deprecated: 'This accessor introduces a wrong way to handle models (since it exposes an internal mechanism to the user. To use correctly this component, you need to follow a different pattent, e.g. what you can find in the examples section in class side of this presenter. Note that you can use SpDropListItem elements as model if you want to replicate the mechanism.'.

	item := SpDropListItem on: aString do: aBlock.
	item icon: anIcon.

	model isEmpty 
		ifTrue: [ self setCollection: { item } ]
		ifFalse: [ self appendCollection: { item } ]
]

{ #category : 'private' }
SpDropListPresenter >> appendCollection: items [

	model collection: (model collection, items)
]

{ #category : 'private' }
SpDropListPresenter >> disableSelectionDuring: aBlock [
	| oldSubscriptions holder |
	
	holder := selection observablePropertyNamed: #selectedIndex.
	oldSubscriptions := holder subscriptions.
	holder subscriptions: #().
	aBlock ensure: [ 
		holder subscriptions: oldSubscriptions ]
]

{ #category : 'api' }
SpDropListPresenter >> display [
	"Answer the formatting block to transform how the elements will be displayed. 
	 See also `SpDropListPresenter>>#display:`"
	
	^ displayBlock
]

{ #category : 'api' }
SpDropListPresenter >> display: aBlock [
	"Set the formatting block to transform how the elements will be displayed. 
	 `aBlock` receives one argument (the element to be displayed) and it should answer a string.
	 See also `SpDropListPresenter>>#display`"

	displayBlock := aBlock 

]

{ #category : 'private' }
SpDropListPresenter >> displayForItem: anItem [
	"The order of the arguments may look weird, but then it seems more natural while using the widget"

	^ self display cull: anItem model cull: anItem
]

{ #category : 'api' }
SpDropListPresenter >> displayIcon [
	"Answer the block that will be used to retrieve the icon to be displayed along with the 
	 elements."

	^ iconBlock
]

{ #category : 'api' }
SpDropListPresenter >> displayIcon: aBlock [	
	"Answer a block that will be used to retrieve the icon to be displayed along with the elements.
	 `aBlock` receives one argument (an element from the list)"
	
	iconBlock := aBlock
]

{ #category : 'private' }
SpDropListPresenter >> dropListItems: dropListItems [
	"Populate the drop list with a list DropListItems"
	
	model collection: dropListItems
]

{ #category : 'api' }
SpDropListPresenter >> emptyList [
	"Empty the list of elements used to populate the drop down list."
	
	self resetSelection.
	model collection: OrderedCollection new.

]

{ #category : 'private' }
SpDropListPresenter >> getIconFor: anItem [

	^ self displayIcon cull: anItem model cull: anItem
]

{ #category : 'private' }
SpDropListPresenter >> getIndex [

	^ selection selectedIndex
]

{ #category : 'private' }
SpDropListPresenter >> getList [

	^ model items
]

{ #category : 'testing' }
SpDropListPresenter >> hasIcons [
	"Answer whether the dropdown list will show icons"
	
	^ iconBlock isNotNil and: [ 
		self model collection anySatisfy: [ :each |
			each icon isNotNil or: [ (self getIconFor: each) isNotNil ] ] ]
]

{ #category : 'initialization' }
SpDropListPresenter >> initialize [
	super initialize.

	model := SpCollectionListModel on: #().
	selection := SpSingleSelectionMode on: self.
	displayBlock := [ :itemModel :item | item label ].
	iconBlock := [ :itemModel :item | item icon ].
	startsWithSelection := true
]

{ #category : 'testing' }
SpDropListPresenter >> isStartWithSelection [

	^ startsWithSelection
]

{ #category : 'api' }
SpDropListPresenter >> items [ 
	"Return the list used to populate the drop list"

	^ self listItems
]

{ #category : 'api' }
SpDropListPresenter >> items: aList [
	"Populate the drop list with a list of ui specific items"
	"`aList` is a list of domain specific objects. If you want to specify more precisely the item actions, see `SpDropListPresenter>>#addItemLabeled:do:`"
	| dropListItems |

	"This is a guard, because I need to reset the selection *before* the list is set"
	(aList isEmpty 
		or: [ aList size < self selectedIndex ]) 
		ifTrue: [ self resetSelection ].
	
	dropListItems := aList collect: [ :each | SpDropListItem on: each do: [ ] ].

	self setCollection: dropListItems
]

{ #category : 'api' }
SpDropListPresenter >> listItems [
	"Return the list used to populate the drop list"
	
	^ self getList collect: [ :e | e model ].
]

{ #category : 'api' }
SpDropListPresenter >> listSize [
	"Return the size of the list of choices"

	^ self listItems size
]

{ #category : 'api' }
SpDropListPresenter >> model [
	"Answer the model containing the elements to be shown in the drop down list.
	 Tipically, the model is a collection of `SpDropListItem`."
	
	^ model
]

{ #category : 'selection' }
SpDropListPresenter >> resetSelection [
	
	self selection unselectAll 
]

{ #category : 'api - selection' }
SpDropListPresenter >> selectFirst [
	
	self selectIndex: 1
]

{ #category : 'api - selection' }
SpDropListPresenter >> selectIndex: anInteger [ 
	"Select the element at position `anInteger` and executes the action associated with it."
	
	self selection selectedIndex = anInteger ifTrue: [ ^ self ].
	
	self selection selectIndex: anInteger.
	"I execute the block associated with the item"
	self selection selectedItem value
]

{ #category : 'api - selection' }
SpDropListPresenter >> selectItem: anItem [ 
	"Select the element `anItem` if it is in the list. 
	 It executes the action associated with the item if it is defined."
	| realItem |
	
	anItem ifNil: [ 
		self selection unselectAll. 
		^ self ].
	
	realItem := model collection detect: [ :each | each model = anItem ].
	self selection selectItem: realItem.
	"I execute the block associated with the item"
	realItem value
]

{ #category : 'api - selection' }
SpDropListPresenter >> selectedIndex [
	"Answer the index of selected item. 
	 You usually do not need to use this method but `SpDropListPresenter>>#selectedItem`."

	^ self getIndex
]

{ #category : 'api - selection' }
SpDropListPresenter >> selectedItem [
	"Answer selected item"

	^ self selection selectedItem 
		ifNotNil: [ :anItem | anItem model ]
]

{ #category : 'api - selection' }
SpDropListPresenter >> selection [
	"Answer selection model, an instance of `SpSingleSelectionMode`."
	
	^ selection
]

{ #category : 'private' }
SpDropListPresenter >> setCollection: items [

	model collection: items.
	(items isNotEmpty
		and: [ startsWithSelection 
		and: [ self selection isEmpty ] ])
		ifTrue: [ self selectIndex: 1 ]
		ifFalse: [ self resetSelection ]
]

{ #category : 'api' }
SpDropListPresenter >> sortingBlock [
	"Answer the block used to sort the elements of the list."

	^ self model sortingBlock
]

{ #category : 'api' }
SpDropListPresenter >> sortingBlock: aBlock [
	"Set the block or `SortFunction` used to sort the elements of the list."

	self model sortingBlock: aBlock
]

{ #category : 'api' }
SpDropListPresenter >> startWithSelection [
	"Indicate when drop list will start with an element selected."

	startsWithSelection := true
]

{ #category : 'api' }
SpDropListPresenter >> startWithoutSelection [
	"Indicate when droplist will start without an element selected."

	startsWithSelection := false
]

{ #category : 'api' }
SpDropListPresenter >> updateItemsKeepingSelection: aCollection [
	"Update list items keeping current selection. 
	 WARNING: aCollection must includes the elements selected."
	
	self disableSelectionDuring: [ 
		| item |
		item := self selectedItem.
		self items: aCollection.
		self selectItem: item ]
]

{ #category : 'api - events' }
SpDropListPresenter >> whenSelectedItemChangedDo: aBlock [
	"Inform when the selected item is changed.
	 `aBlock` receive one optional argument: the selected item (can be nil)"

	selection whenChangedDo: [	aBlock cull: self selectedItem ]
]

{ #category : 'api - events' }
SpDropListPresenter >> whenSelectionChangedDo: aBlock [
	"Inform when the selection is changed.
	 The method should be used only if you are interested in the fact that 
	 there was a change, without caring about what has changed.
	 If you are interested in the items, use `SpDropListPresenter>>#whenSelectedItemChanged:`

	`aBlock` receives an optional argument with the selection object."

	selection whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpDropListPresenter >> whenSortingBlockChangedDo: aBlock [
	"Inform when sorting block has changed.
	 `aBlock` receive 3 optional arguments: 
	 - new value 
	 - old value 
	 - announcement triggered"

	self model whenSortingBlockChangedDo: aBlock
]
