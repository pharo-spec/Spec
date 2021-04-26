Class {
	#name : #SpConfirmDialog,
	#superclass : #SpDialogPresenter,
	#instVars : [
		'label',
		'image',
		'title',
		'initialExtent',
		'acceptLabel',
		'cancelLabel'
	],
	#category : #'Spec2-Dialogs'
}

{ #category : #accessing }
SpConfirmDialog class >> defaultAcceptLabel [

	^ 'Yes'
]

{ #category : #accessing }
SpConfirmDialog class >> defaultCancelLabel [

	^ 'No'
]

{ #category : #accessing }
SpConfirmDialog class >> defaultExtent [

	^ 400@100
]

{ #category : #specs }
SpConfirmDialog class >> defaultSpec [

	^ SpBoxLayout newVertical
		borderWidth: 5;
		spacing: 5;
		add: (SpBoxLayout newHorizontal
			spacing: 5;
			add: #image expand: false;
			add: #label;
			yourself);
		yourself
]

{ #category : #accessing }
SpConfirmDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #accessing }
SpConfirmDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #accessing }
SpConfirmDialog >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : #accessing }
SpConfirmDialog >> cancelLabel: aString [

	cancelLabel := aString
]

{ #category : #accessing }
SpConfirmDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #accessing }
SpConfirmDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : #initialization }
SpConfirmDialog >> initialize [
	
	super initialize.
	self title: 'Confirm'
]

{ #category : #initialization }
SpConfirmDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addButton: self cancelLabel do: [ :presenter | presenter beCancel; close ];
		addDefaultButton: self acceptLabel do: [ :presenter | presenter beOk; close ]
		
]

{ #category : #initialization }
SpConfirmDialog >> initializePresenters [

	image := self newImage.
	label := self newLabel.
	
]

{ #category : #initialization }
SpConfirmDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent
]

{ #category : #accessing }
SpConfirmDialog >> label: aString [

	label label: aString
]

{ #category : #api }
SpConfirmDialog >> openDialogWithSpec [
	| dialog |
	
	dialog := super openDialogWithSpec.
	^ dialog isOk
]

{ #category : #accessing }
SpConfirmDialog >> title [

	^ title
]

{ #category : #accessing }
SpConfirmDialog >> title: aString [

	title := aString
]
