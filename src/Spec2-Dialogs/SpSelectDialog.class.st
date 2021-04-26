Class {
	#name : #SpSelectDialog,
	#superclass : #SpDialogPresenter,
	#instVars : [
		'label',
		'title',
		'initialExtent',
		'acceptLabel',
		'cancelLabel',
		'list'
	],
	#category : #'Spec2-Dialogs'
}

{ #category : #accessing }
SpSelectDialog class >> defaultAcceptLabel [

	^ 'Accept'
]

{ #category : #accessing }
SpSelectDialog class >> defaultCancelLabel [

	^ 'Cancel'
]

{ #category : #accessing }
SpSelectDialog class >> defaultExtent [

	^ 400@300
]

{ #category : #specs }
SpSelectDialog class >> defaultSpec [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add: #label expand: false;
		add: #list;
		yourself
]

{ #category : #accessing }
SpSelectDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #accessing }
SpSelectDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #accessing }
SpSelectDialog >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : #accessing }
SpSelectDialog >> cancelLabel: aString [

	cancelLabel := aString
]

{ #category : #accessing }
SpSelectDialog >> display: aBlock [

	list display: aBlock
]

{ #category : #accessing }
SpSelectDialog >> displayIcon: aBlock [

	list displayIcon: aBlock
]

{ #category : #accessing }
SpSelectDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #accessing }
SpSelectDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : #initialization }
SpSelectDialog >> initialize [
	
	super initialize.
	self title: 'Request'
]

{ #category : #initialization }
SpSelectDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addButton: self cancelLabel do: [ :presenter | presenter beCancel; close ];
		addDefaultButton: self acceptLabel do: [ :presenter | presenter beOk; close ]
]

{ #category : #initialization }
SpSelectDialog >> initializePresenters [

	label := self newLabel.
	list := self newList.
	
	list addStyle: 'sgaSelectList'.
	list whenActivatedDo: [ self window triggerOkAction ]
]

{ #category : #initialization }
SpSelectDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent;
		whenOpenedDo: [ list takeKeyboardFocus ]
]

{ #category : #accessing }
SpSelectDialog >> items [

	^ list items
]

{ #category : #accessing }
SpSelectDialog >> items: aCollection [

	list items: aCollection
]

{ #category : #accessing }
SpSelectDialog >> label: aString [

	label label: aString
]

{ #category : #api }
SpSelectDialog >> openDialogWithSpec [
	| dialog |
	
	dialog := super openDialogWithSpec.
	^ dialog isOk
		ifTrue: [ list selectedItem ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
SpSelectDialog >> title [

	^ title
]

{ #category : #accessing }
SpSelectDialog >> title: aString [

	title := aString
]
