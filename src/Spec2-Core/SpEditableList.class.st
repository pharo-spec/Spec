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
	#name : #SpEditableList,
	#superclass : #SpPresenter,
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
		'label'
	],
	#category : #'Spec2-Core-Widgets'
}

{ #category : #spec }
SpEditableList class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
					addLast: #addButton expand: false;
					addLast: #removeButton expand: false;
					yourself)
			expand: false;
		add:
			(SpBoxLayout newHorizontal
				add: #list;
				add:
					(SpBoxLayout newVertical
							add: #topButton expand: false fill: false padding: 0;
							add: #upButton expand: false fill: false padding: 0;
							add: #downButton expand: false fill: false padding: 0;
							add: #bottomButton expand: false fill: false padding: 0;
							yourself)
					expand: false;
				yourself);
		yourself
]

{ #category : #'instance creation' }
SpEditableList class >> new: aCollection [
	^ self new items: aCollection.
		
]

{ #category : #spec }
SpEditableList class >> withoutOrderingBar [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
					addLast: #addButton expand: false;
					addLast: #removeButton expand: false;
					yourself)
			expand: false;
		add: #list;
		yourself
]

{ #category : #accessing }
SpEditableList >> addButton [
	^ addButton
]

{ #category : #api }
SpEditableList >> addItemBlock: aBlock [
	addItemBlock := aBlock.
]

{ #category : #accessing }
SpEditableList >> bottomButton [
	^ bottomButton
]

{ #category : #initialization }
SpEditableList >> connectPresenters [
	super connectPresenters.
	addButton action: [ 
		| newItem |
		newItem := addItemBlock value.
		newItem ifNotNil: [ 
			self items add: newItem.
			self refresh. ] ].
	removeButton 
		action: [ self items remove: self selectedItem.
					self refresh. ].
	topButton action: [ self moveElementAt: self selectedIndex to: 1 ].
	bottomButton action: [ 
		self moveElementAt: self selectedIndex to: self items size ].
	upButton action: [ 
		self moveElementAt: self selectedIndex to: self selectedIndex - 1 ].
	downButton action: [ 
		self moveElementAt: self selectedIndex to: self selectedIndex + 1 ]
]

{ #category : #api }
SpEditableList >> display: aBlock [

	list display: aBlock
]

{ #category : #accessing }
SpEditableList >> downButton [
	^ downButton
]

{ #category : #initialization }
SpEditableList >> initialize [
	super initialize.
	title := 'Title'.
	okBlock := [  ]
]

{ #category : #initialization }
SpEditableList >> initializeDialogWindow: aWindow [

	aWindow 
		addButton: 'Ok' 
		do: [ :presenter | 
			self performOkAction. 
			presenter close ]
]

{ #category : #initialization }
SpEditableList >> initializePresenters [
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
		icon: (self iconNamed: #addIcon);
		help: 'Add a new item to the list'.
	removeButton
		addStyle: 'small';
		icon: (self iconNamed: #removeIcon);
		help: 'Remove a item from the list'.
	upButton
		addStyle: 'small';
		icon: (self iconNamed: #upIcon);
		help: 'Move this item up from one element'.
	downButton
		addStyle: 'small';
		icon: (self iconNamed: #downIcon);
		help: 'Move this item down from one element'.
	topButton
		addStyle: 'small';
		icon: (self iconNamed: #topIcon);
		help: 'Move this item on the first position of the list'.
	bottomButton
		addStyle: 'small';
		icon: (self iconNamed: #bottomIcon);
		help: 'Move this item on the last position of the list'
]

{ #category : #initialization }
SpEditableList >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: self title
]

{ #category : #accessing }
SpEditableList >> items [
	^ list model items
]

{ #category : #private }
SpEditableList >> items: anItemList [
	list items: anItemList.
]

{ #category : #accessing }
SpEditableList >> label: aString [
	label label: aString 
]

{ #category : #accessing }
SpEditableList >> list [
	^ list
]

{ #category : #private }
SpEditableList >> moveElementAt: index to: newIndex [
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

{ #category : #api }
SpEditableList >> okAction: aBlock [

	okBlock := aBlock
]

{ #category : #private }
SpEditableList >> performOkAction [

	okBlock value
]

{ #category : #api }
SpEditableList >> refresh [
	self items: self items
]

{ #category : #accessing }
SpEditableList >> removeButton [
	^ removeButton
]

{ #category : #api }
SpEditableList >> selectItem: anIndex [
	list selectItem: anIndex
]

{ #category : #api }
SpEditableList >> selectedIndex [
	^ list selection selectedIndex
]

{ #category : #api }
SpEditableList >> selectedItem [
	^ list selection selectedItem
]

{ #category : #accessing }
SpEditableList >> title [
	^ title
]

{ #category : #accessing }
SpEditableList >> title: aTitle [
	title := aTitle 
]

{ #category : #accessing }
SpEditableList >> topButton [
	^ topButton
]

{ #category : #accessing }
SpEditableList >> upButton [
	^ upButton
]

{ #category : #api }
SpEditableList >> whenSelectionChangedDo: aBlockClosure [ 
	list whenSelectionChangedDo: aBlockClosure
]
