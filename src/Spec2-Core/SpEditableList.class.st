"
This widget allows you to edit a list of items :
- add / remove an item to/from the list 
- order the list by moving elements up/down/top/bottom.

The default behavior is to do a copy of the list. The widget works with its internal copy. It allows the user to accept / reject changes (for example by opening the widget in a DialogWindow) before affecting the original list. It is your responsability to copy EditableList items back to the original list.

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

{ #category : #accessing }
SpEditableList class >> buttonWidth [
	^ 26
]

{ #category : #spec }
SpEditableList class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
					add: #label;
					add: #addButton width: self buttonWidth;
					add: #removeButton width: self buttonWidth;
					yourself)
			height: 25;
		add:
			(SpBoxLayout newHorizontal
				add: #list;
				add:
					(SpBoxLayout newVertical
							add: '';
							add: #topButton height: self orderingButtonHeight;
							add: #upButton height: self orderingButtonHeight;
							add: #downButton height: self orderingButtonHeight;
							add: #bottomButton height: self orderingButtonHeight;
							add: ' ';
							yourself)
					width: 20;
				yourself);
		yourself
]

{ #category : #'instance creation' }
SpEditableList class >> new: aCollection [
	^ self new items: aCollection copy.
		
]

{ #category : #accessing }
SpEditableList class >> orderingButtonHeight [
	^ 40
]

{ #category : #spec }
SpEditableList class >> withoutOrderingBar [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
					add: #label;
					add: #addButton width: self buttonWidth;
					add: #removeButton width: self buttonWidth;
					yourself)
			height: 25;
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
	addButton
		action: [ | requirement |
			requirement := addItemBlock value.
			requirement
				ifNotNil: [ self items: (self list model items copyWith: requirement) ] ].
	removeButton
		action: [ self
				items: (list model items copyWithoutIndex: list selection selectedIndex) ].
	topButton
		action: [ self moveElementAt: list selection selectedIndex to: 1 ].
	bottomButton
		action: [ self
				moveElementAt: list selection selectedIndex
				to: list model items size ].
	upButton
		action: [ self
				moveElementAt: list selection selectedIndex
				to: list selection selectedIndex - 1 ].
	downButton
		action: [ self
				moveElementAt: list selection selectedIndex
				to: list selection selectedIndex + 1 ]
]

{ #category : #api }
SpEditableList >> display: aBlock [

	list display: aBlock
]

{ #category : #accessing }
SpEditableList >> displayedItems [
	^ list model items
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
		icon: (self iconNamed: #addIcon);
		help: 'Add a new item to the list'.
	removeButton
		icon: (self iconNamed: #removeIcon);
		help: 'Remove a item from the list'.
	upButton
		icon: (self iconNamed: #upIcon);
		help: 'Move this item up from one element'.
	downButton
		icon: (self iconNamed: #downIcon);
		help: 'Move this item down from one element'.
	topButton
		icon: (self iconNamed: #topIcon);
		help: 'Move this item on the first position of the list'.
	bottomButton
		icon: (self iconNamed: #bottomIcon);
		help: 'Move this item on the last position of the list'
]

{ #category : #initialization }
SpEditableList >> initializeWindow: aWindowPresenter [
	aWindowPresenter title: self title
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
	| elementToMove orderedList |
	(newIndex < 1 or: [ newIndex > list items size ])
		ifTrue: [ ^ self ].
	elementToMove := list itemAt: index.
	orderedList := list items copy asOrderedCollection
		removeAt: index;
		add: elementToMove beforeIndex: newIndex;
		yourself.
	self items: orderedList.
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

{ #category : #accessing }
SpEditableList >> removeButton [
	^ removeButton
]

{ #category : #api }
SpEditableList >> selectItem: anIndex [
	list selectItem: anIndex
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
