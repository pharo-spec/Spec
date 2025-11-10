"
A dialog that allow the users to select from a list of `items`
"
Class {
	#name : 'SpSelectDialog',
	#superclass : 'SpAbstractCancelableMessageDialog',
	#instVars : [
		'list'
	],
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'accessing' }
SpSelectDialog class >> defaultExtent [

	^ 450@300
]

{ #category : 'documentation' }
SpSelectDialog class >> documentFactoryMethodSelector [
	
	^ #newSelect
]

{ #category : 'examples' }
SpSelectDialog class >> example [

	| presenter |
	presenter := self new.
	presenter
		title: 'Select example';
		label: 'Select a class';
		items: Smalltalk allClassesAndTraits;
		display: [ :each | each name ];
		displayIcon: [ :each | self iconNamed: each systemIconName ];
		onAccept: [ :dialog |
			dialog presenter inform: dialog presenter selectedItem asString ];
		openDialog
]

{ #category : 'examples' }
SpSelectDialog class >> exampleModal [

	| dialog selection |
	dialog := self new. 
	selection := dialog
		             title: 'Select modal example';
		             label: 'Select a class';
		             items: Smalltalk allClassesAndTraits;
		             display: [ :each | each name ];
		             displayIcon: [ :each |
			             self iconNamed: each systemIconName ];
		             openModal.

	selection ifNotNil: [ dialog inform: selection asString ]
]

{ #category : 'examples' }
SpSelectDialog class >> exampleMultiLineLabel [

	| presenter label |

	label := String streamContents: [ :s |
		s nextPutAll: 'Select a class';
		  cr;
		  cr;
		  nextPutAll: 'Something else two lines bellow with a really long long long long text that will wrap'
		 ].
	
	presenter := self new.

	presenter
		title: 'Select example';
		label: label;
		items: Smalltalk allClassesAndTraits;
		display: [ :each | each name ];
		displayIcon: [ :each | self iconNamed: each systemIconName ];
		onAccept: [ :dialog |
			dialog presenter inform: dialog presenter selectedItem asString ];
		openDialog
]

{ #category : 'layout' }
SpSelectDialog >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 5;
		add: label height: self calculateLabelHeight;
		add: list;
		yourself
]

{ #category : 'accessing' }
SpSelectDialog >> defaultTitle [

	^ 'Request'
]

{ #category : 'api' }
SpSelectDialog >> display: aBlock [

	list display: aBlock
]

{ #category : 'api' }
SpSelectDialog >> displayIcon: aBlock [

	list displayIcon: aBlock
]

{ #category : 'initialization' }
SpSelectDialog >> initializePresenters [

	super initializePresenters.

	list := self newList.
	list searchMatching: [ :item :aString | 
		(list display value: item) asLowercase beginsWith: aString asLowercase ].
	list addStyle: 'spSelectList'.
	list whenActivatedDo: [ self accept ]
]

{ #category : 'initialization' }
SpSelectDialog >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.

	aWindowPresenter whenOpenedDo: [ list takeKeyboardFocus ]
]

{ #category : 'api' }
SpSelectDialog >> items [

	^ list items
]

{ #category : 'api' }
SpSelectDialog >> items: aCollection [

	list items: aCollection.
	aCollection ifNotEmpty: [ 
		list selectItem: aCollection first ]
]

{ #category : 'accessing' }
SpSelectDialog >> list [

	^ list 
]

{ #category : 'api - showing' }
SpSelectDialog >> openModal [
	| dialog |
	
	dialog := super openModal.
	^ dialog isOk
		ifTrue: [ list selectedItem ]
		ifFalse: [ nil ]
]

{ #category : 'api - selection' }
SpSelectDialog >> selectFirst [

	list selectFirst
]

{ #category : 'api - selection' }
SpSelectDialog >> selectIndex: aNumber [

	list selectIndex: aNumber
]

{ #category : 'api - selection' }
SpSelectDialog >> selectItem: anObject [

	list selectItem: anObject
]

{ #category : 'api - selection' }
SpSelectDialog >> selectedItem [

	^ list selectedItem
]
