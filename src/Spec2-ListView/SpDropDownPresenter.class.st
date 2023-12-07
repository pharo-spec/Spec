Class {
	#name : 'SpDropDownPresenter',
	#superclass : 'SpAbstractWidgetPresenter',
	#instVars : [
		'setupAction',
		'bindAction',
		'model',
		'display',
		'selection'
	],
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
}

{ #category : 'specs' }
SpDropDownPresenter class >> adapterName [

	^ #DropDownAdapter
]

{ #category : 'api' }
SpDropDownPresenter >> bind: aBlock [

	bindAction := aBlock
]

{ #category : 'private' }
SpDropDownPresenter >> bindAction [

	^ bindAction
]

{ #category : 'private' }
SpDropDownPresenter >> display [

	^ display
]

{ #category : 'api' }
SpDropDownPresenter >> display: aBlock [
	"Set the block that will be applied on the selected list item. 
	 The result of the block will be used to display the item on the screen, 
	 as the text field content.
	 `aBlock` receives one argument.
	 "

	display := aBlock
]

{ #category : 'initialization' }
SpDropDownPresenter >> initialize [
	
	super initialize.
	self model: 	self newEmptyModel.
	self initializeItemFactory.
	selection := SpSingleSelectionMode on: self.
	self display: [ :anObject | anObject asString ]
]

{ #category : 'initialization' }
SpDropDownPresenter >> initializeItemFactory [
	"Just set up the defaults (to ensure we have a working list at any moment)"
	
	self setup: [ :aPresenter | 
		aPresenter newLabel ].
	self bind: [ :aPresenter :anObject | 
		aPresenter label: (self display value: anObject) asString ]
]

{ #category : 'api' }
SpDropDownPresenter >> items [
	"Answer the items of the list"
	
	^ self model collection
]

{ #category : 'api' }
SpDropDownPresenter >> items: aSequenceableCollection [
	"Set the items of the list.
	`aSequenceableCollection` is a collection of your domain specific items.
	This resets the collection model and unselects any previously selected item."
	
	model collection: aSequenceableCollection
]

{ #category : 'api' }
SpDropDownPresenter >> model [
	"Answer the model for this list. 
	 It is tipically, an instance of `SpCollectionListModel`."
	
	^ model
]

{ #category : 'api' }
SpDropDownPresenter >> model: aModel [
	"Sets the model used to feed the list presenter with elements of the list. 
	 It is tipically an instance of `SpCollectionListModel`."
	
	model := aModel.
	model whenChangedDo: [ 
		self withAdapterDo: [ :anAdapter | anAdapter refreshList ] ]
]

{ #category : 'private' }
SpDropDownPresenter >> newEmptyModel [

	^ SpCollectionListModel on: #()
]

{ #category : 'api - selection' }
SpDropDownPresenter >> selectFirst [
	"Select first element in list. 
	 Useful to avoid selecting by index."

	^ self selectIndex: 1
]

{ #category : 'api - selection' }
SpDropDownPresenter >> selectIndex: anInteger [ 
	"Select item at position `anInteger`.
	 Selection will not scroll the presenter view to show selected element."

	self selection selectIndex: anInteger
]

{ #category : 'api - selection' }
SpDropDownPresenter >> selectItem: anItem [ 
	"Select `anItem` if it is included in model list.
	 It does not scrolls to selected element."

	self selection selectItem: anItem
]

{ #category : 'api - selection' }
SpDropDownPresenter >> selectedIndex [
	"Return selected index."

	^ self selection selectedIndex
]

{ #category : 'api - selection' }
SpDropDownPresenter >> selectedItem [
	"Return selected item."

	^ self selection selectedItem
]

{ #category : 'api - selection' }
SpDropDownPresenter >> selection [
	"Answer the selection object (an instance of `SpSingleSelectionMode` or `SpMultipleSelectionMode`).
	 This is not the item selected, but the selection container (it may contain one or many selected 
	 items)"
	
	^ selection
]

{ #category : 'api' }
SpDropDownPresenter >> setup: aBlock [

	setupAction := aBlock
]

{ #category : 'private' }
SpDropDownPresenter >> setupAction [

	^ setupAction
]

{ #category : 'api - events' }
SpDropDownPresenter >> whenSelectedDo: aBlock [
	"Inform when an item was selected (a real object in the items list).
	 `aBlock` receives one argument (the new selected element)"

	self whenSelectionChangedDo: [ :aSelection | 
		aSelection selectedItem 
			ifNotNil: [ :item | aBlock value: item ] ]
]

{ #category : 'api - events' }
SpDropDownPresenter >> whenSelectedItemChangedDo: aBlock [
	"Inform when the selected item is changed.
	 `aBlock` receive one optional argument: the selected item (can be nil)"

	self selection whenChangedDo: [ aBlock cull: self selectedItem ]
]

{ #category : 'api - events' }
SpDropDownPresenter >> whenSelectionChangedDo: aBlock [
	"Inform when there are changes in selection.
	This method works for all selection modes (single, multiple and no selection).
	`aBlock` receives an optional argument with the selection object."

	self selection whenChangedDo: aBlock
]