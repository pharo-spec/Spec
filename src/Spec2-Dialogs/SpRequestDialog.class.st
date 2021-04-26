"
A simple dialog to request some information (a text)
"
Class {
	#name : #SpRequestDialog,
	#superclass : #SpDialogPresenter,
	#instVars : [
		'label',
		'textInput',
		'title',
		'initialExtent',
		'acceptLabel',
		'cancelLabel'
	],
	#category : #'Spec2-Dialogs'
}

{ #category : #accessing }
SpRequestDialog class >> defaultExtent [

	^ 400@140
]

{ #category : #specs }
SpRequestDialog class >> defaultSpec [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add: #label expand: false;
		add: #textInput expand: false;
		yourself
]

{ #category : #example }
SpRequestDialog class >> example [

	self new
		label: 'You are seeing an inform dialog!';
		onAccept: [ :dialog | self inform: dialog presenter text ];
		openDialogWithSpec
]

{ #category : #example }
SpRequestDialog class >> exampleModal [
	| dialog |

	dialog := self new
		label: 'You are seeing an inform dialog!';
		openModalWithSpec.
		
	dialog isOk ifTrue: [ 
		self inform: dialog presenter text ]
]

{ #category : #accessing }
SpRequestDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #accessing }
SpRequestDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #accessing }
SpRequestDialog >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : #accessing }
SpRequestDialog >> cancelLabel: aString [

	cancelLabel := aString
]

{ #category : #accessing }
SpRequestDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #accessing }
SpRequestDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : #initialization }
SpRequestDialog >> initialize [
	
	super initialize.
	self title: 'Request'
]

{ #category : #initialization }
SpRequestDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addButton: self cancelLabel do: [ :presenter | self cancel ];
		addDefaultButton: self acceptLabel do: [ :presenter | self accept ]
]

{ #category : #initialization }
SpRequestDialog >> initializePresenters [

	label := self newLabel.
	textInput := self newTextInput
]

{ #category : #initialization }
SpRequestDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent;
		whenOpenedDo: [ textInput takeKeyboardFocus ]
]

{ #category : #accessing }
SpRequestDialog >> label: aString [

	label label: aString
]

{ #category : #api }
SpRequestDialog >> openDialogWithSpec [
	| dialog |
	
	dialog := super openDialogWithSpec.
	^ dialog isOk
		ifTrue: [ self text trimmed ]
		ifFalse: [ nil ]
]

{ #category : #accessing }
SpRequestDialog >> text [ 
	
	^ textInput text trimmed
]

{ #category : #accessing }
SpRequestDialog >> text: aString [

	textInput text: aString
]

{ #category : #accessing }
SpRequestDialog >> title [

	^ title
]

{ #category : #accessing }
SpRequestDialog >> title: aString [

	title := aString
]
