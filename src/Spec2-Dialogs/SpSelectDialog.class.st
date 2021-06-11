"
A dialog that allow the users to select from a list of `items`
"
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
SpSelectDialog class >> defaultExtent [

	^ 450@300
]

{ #category : #specs }
SpSelectDialog class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 5;
		add: #label expand: false;
		add: #list;
		yourself
]

{ #category : #documentation }
SpSelectDialog class >> documentFactoryMethodSelector [
	
	^ #newSelect
]

{ #category : #examples }
SpSelectDialog class >> example [

	self new
		title: 'Select example';
		label: 'Select a class';
		items: Smalltalk allClassesAndTraits;
		display: [ :each | each name ];
		displayIcon: [ :each | each systemIcon ];
		onAccept: [ :dialog | self inform: dialog presenter selectedItem asString ];
		openDialogWithSpec
]

{ #category : #examples }
SpSelectDialog class >> exampleModal [
	| selection |

	selection := self new
		title: 'Select modal example';
		label: 'Select a class';
		items: Smalltalk allClassesAndTraits;
		display: [ :each | each name ];
		displayIcon: [ :each | each systemIcon ];
		openModalWithSpec.
		
	selection ifNotNil: [ 
		self inform: selection asString ]
]

{ #category : #api }
SpSelectDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #api }
SpSelectDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #api }
SpSelectDialog >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : #api }
SpSelectDialog >> cancelLabel: aString [

	cancelLabel := aString
]

{ #category : #api }
SpSelectDialog >> display: aBlock [

	list display: aBlock
]

{ #category : #api }
SpSelectDialog >> displayIcon: aBlock [

	list displayIcon: aBlock
]

{ #category : #api }
SpSelectDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #api }
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
		addButton: self cancelLabel do: [ :presenter | self cancel ];
		addDefaultButton: self acceptLabel do: [ :presenter | self accept ]
]

{ #category : #initialization }
SpSelectDialog >> initializePresenters [

	label := self newLabel.
	list := self newList.
	
	list addStyle: 'spSelectList'.
	list whenActivatedDo: [ self accept ]
]

{ #category : #initialization }
SpSelectDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent;
		whenOpenedDo: [ list takeKeyboardFocus ]
]

{ #category : #api }
SpSelectDialog >> items [

	^ list items
]

{ #category : #api }
SpSelectDialog >> items: aCollection [

	list items: aCollection
]

{ #category : #api }
SpSelectDialog >> label: aString [

	label label: aString
]

{ #category : #'api - showing' }
SpSelectDialog >> openModalWithSpec [
	| dialog |
	
	dialog := super openModalWithSpec.
	^ dialog isOk
		ifTrue: [ list selectedItem ]
		ifFalse: [ nil ]
]

{ #category : #api }
SpSelectDialog >> selectedItem [

	^ list selectedItem
]

{ #category : #api }
SpSelectDialog >> title [

	^ title
]

{ #category : #api }
SpSelectDialog >> title: aString [

	title := aString
]
