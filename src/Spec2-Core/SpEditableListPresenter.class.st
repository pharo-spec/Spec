"
This widget allows you to edit a list of items :
- add / remove an item to/from the list 
- order the list by moving elements up/down/top/bottom.

The default behavior is to work directly on the model collection. It means the collection has to support #add:, #remove: methods (e.g. OrderedCollection).
If you prefer, you can do a copy of the list and give the copy to the EditableList. It will allow the user to accept / reject changes (for example by opening the widget in a DialogWindow) before affecting the original list. If you use a copy of your collection, then it is your responsability to copy EditableList items back to the original list.

The addItemBlock is used to provide a way to give the item to add (e.g. a UIManager default chooseFrom: values:).

Example:
self example
"
Class {
	#name : 'SpEditableListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'title',
		'list',
		'addButton',
		'removeButton',
		'upButton',
		'downButton',
		'topButton',
		'bottomButton',
		'addItemBlock',
		'okBlock',
		'label',
		'removeItemBlock'
	],
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'layout' }
SpEditableListPresenter class >> defaultLayout [
	^ self layoutWithOrdering: true
]

{ #category : 'layout' }
SpEditableListPresenter class >> layoutWithOrdering: useOrdering [
	| listLayout |
	listLayout := SpBoxLayout newLeftToRight
				add: #list;
				yourself.
				
	useOrdering 
		ifTrue: [ listLayout 
					add:
						(SpBoxLayout newTopToBottom
							add: #topButton expand: false;
							add: #upButton expand: false;
							add: #downButton expand: false;
							add: #bottomButton expand: false;
							yourself)
					expand: false ].

	^ SpBoxLayout newTopToBottom
		add:
			(SpBoxLayout newLeftToRight
					addLast: #addButton expand: false;
					addLast: #removeButton expand: false;
					yourself)
			expand: false;
		add: listLayout;
		yourself
]

{ #category : 'instance creation' }
SpEditableListPresenter class >> new: aCollection [
	^ self new items: aCollection.
		
]

{ #category : 'layout' }
SpEditableListPresenter class >> withoutOrderingBar [
	^ self layoutWithOrdering: false
]

{ #category : 'accessing' }
SpEditableListPresenter >> addButton [
	^ addButton
]

{ #category : 'api' }
SpEditableListPresenter >> addItemBlock: aBlock [
	addItemBlock := aBlock.
]

{ #category : 'accessing' }
SpEditableListPresenter >> bottomButton [
	^ bottomButton
]

{ #category : 'initialization' }
SpEditableListPresenter >> connectPresenters [
	super connectPresenters.
	addButton action: [ 
		| newItem |
		newItem := addItemBlock value.
		newItem ifNotNil: [ 
			self items add: newItem.
			self 
				refresh;
				selectItem: newItem ] ].
	removeButton 
		action: [ removeItemBlock cull: self selectedItem ].
	topButton action: [ self moveElementAt: self selectedIndex to: 1 ].
	bottomButton action: [ 
		self moveElementAt: self selectedIndex to: self items size ].
	upButton action: [ 
		self moveElementAt: self selectedIndex to: self selectedIndex - 1 ].
	downButton action: [ 
		self moveElementAt: self selectedIndex to: self selectedIndex + 1 ]
]

{ #category : 'api' }
SpEditableListPresenter >> display: aBlock [

	list display: aBlock
]

{ #category : 'accessing' }
SpEditableListPresenter >> downButton [
	^ downButton
]

{ #category : 'initialization' }
SpEditableListPresenter >> initialize [
	super initialize.
	title := 'Title'.
	okBlock := [  ].
	removeItemBlock := [ :item | 
								item
									ifNotNil: [ self items remove: item.
													self refresh. ] ]
]

{ #category : 'initialization' }
SpEditableListPresenter >> initializeDialogWindow: aWindow [

	aWindow addDefaultButton: 'Ok' do: [ :presenter | 
		self performOkAction. 
		presenter close ]
]

{ #category : 'initialization' }
SpEditableListPresenter >> initializePresenters [

	label := self newLabel.
	list := self newList.
	addButton := self newButton.
	removeButton := self newButton.
	upButton := self newButton.
	downButton := self newButton.
	topButton := self newButton.
	bottomButton := self newButton.
	addButton
		addStyle: 'small';
		addStyle: 'flat';
		icon: (self iconNamed: #add);
		help: 'Add a new item to the list'.
	removeButton
		addStyle: 'small';
		addStyle: 'flat';
		icon: (self iconNamed: #remove);
		help: 'Remove a item from the list'.
	upButton
		addStyle: 'small';
		addStyle: 'flat';
		icon: (self iconNamed: #up);
		help: 'Move this item up from one element'.
	downButton
		addStyle: 'small';
		addStyle: 'flat';
		icon: (self iconNamed: #down);
		help: 'Move this item down from one element'.
	topButton
		addStyle: 'small';
		addStyle: 'flat';
		icon: (self iconNamed: #top);
		help: 'Move this item on the first position of the list'.
	bottomButton
		addStyle: 'small';
		addStyle: 'flat';
		icon: (self iconNamed: #bottom);
		help: 'Move this item on the last position of the list'
]

{ #category : 'initialization' }
SpEditableListPresenter >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: self title
]

{ #category : 'accessing' }
SpEditableListPresenter >> items [
	^ list model items
]

{ #category : 'private' }
SpEditableListPresenter >> items: anItemList [
	list items: anItemList.
]

{ #category : 'accessing' }
SpEditableListPresenter >> label: aString [
	label label: aString 
]

{ #category : 'accessing' }
SpEditableListPresenter >> list [
	^ list
]

{ #category : 'private' }
SpEditableListPresenter >> moveElementAt: index to: newIndex [
	"WARNING: this method can only be used if the model is an OrderedCollection"
	| elementToMove |
	
	(newIndex between: 1 and: self items size) 
		ifFalse: [ ^ self ].
		
	elementToMove := list itemAt: index.
	self items 
		remove: elementToMove;
		add: elementToMove beforeIndex: newIndex.
	
	self refresh.
	self list selectIndex: newIndex
]

{ #category : 'initialization' }
SpEditableListPresenter >> newList [
	"Default list collection is an Array.
	As this presenter aims to add / remove items from the list, we need a growable collection"
	^ (self instantiate: SpListPresenter)
			items: OrderedCollection new;
			yourself
]

{ #category : 'api' }
SpEditableListPresenter >> okAction: aBlock [

	okBlock := aBlock
]

{ #category : 'private' }
SpEditableListPresenter >> performOkAction [

	okBlock value
]

{ #category : 'api' }
SpEditableListPresenter >> refresh [
	self resetSelection.
	self items: self items
]

{ #category : 'accessing' }
SpEditableListPresenter >> removeButton [
	^ removeButton
]

{ #category : 'api' }
SpEditableListPresenter >> removeItem: anObject [
	self items remove: anObject.
	list selection unselectAll
]

{ #category : 'api' }
SpEditableListPresenter >> removeItemBlock: aBlock [
	removeItemBlock := aBlock.
]

{ #category : 'api' }
SpEditableListPresenter >> resetSelection [
	self selectIndex: 0
]

{ #category : 'api' }
SpEditableListPresenter >> selectIndex: anIndex [
	list selectIndex: anIndex
]

{ #category : 'api' }
SpEditableListPresenter >> selectItem: anObject [
	list selectItem: anObject
]

{ #category : 'api' }
SpEditableListPresenter >> selectedIndex [
	^ list selection selectedIndex
]

{ #category : 'api' }
SpEditableListPresenter >> selectedItem [
	^ list selection selectedItem
]

{ #category : 'accessing' }
SpEditableListPresenter >> title [
	^ title
]

{ #category : 'accessing' }
SpEditableListPresenter >> title: aTitle [
	title := aTitle 
]

{ #category : 'accessing' }
SpEditableListPresenter >> topButton [
	^ topButton
]

{ #category : 'accessing' }
SpEditableListPresenter >> upButton [
	^ upButton
]

{ #category : 'api' }
SpEditableListPresenter >> whenSelectionChangedDo: aBlock [
	list whenSelectionChangedDo: aBlock
]
