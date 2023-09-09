"
A dialog to present some simple information to users.
"
Class {
	#name : #SpAlertDialog,
	#superclass : #SpDialogPresenter,
	#instVars : [
		'label',
		'title',
		'initialExtent',
		'acceptLabel'
	],
	#category : #'Spec2-Dialogs'
}

{ #category : #accessing }
SpAlertDialog class >> defaultAcceptLabel [

	^ 'Ok'
]

{ #category : #accessing }
SpAlertDialog class >> defaultExtent [

	^ 450@120
]

{ #category : #layout }
SpAlertDialog class >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		borderWidth: 5;
		spacing: 5;
		add: (SpBoxLayout newLeftToRight
			vAlignCenter;
			spacing: 5;
			add: #image expand: false;
			add: #label;
			yourself);
		yourself
]

{ #category : #documentation }
SpAlertDialog class >> documentFactoryMethodSelector [
	
	^ #newInform
]

{ #category : #examples }
SpAlertDialog class >> example [

	self new
		title: 'Alert example';
		label: 'You are seeing an alert dialog!';
		acceptLabel: 'Close this!';
		openDialog
]

{ #category : #examples }
SpAlertDialog class >> exampleModal [

	self new
		title: 'Alert modal example';
		label: 'You are seeing an alert dialog!';
		acceptLabel: 'Close this!';
		openModal
]

{ #category : #api }
SpAlertDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #api }
SpAlertDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #accessing }
SpAlertDialog >> defaultIcon [

	^ self application iconNamed: #info
]

{ #category : #api }
SpAlertDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #api }
SpAlertDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : #initialization }
SpAlertDialog >> initialize [

	super initialize.
	self title: 'Inform'
]

{ #category : #initialization }
SpAlertDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addDefaultButton: self acceptLabel 
		do: [ :presenter | self accept ]
		
]

{ #category : #initialization }
SpAlertDialog >> initializePresenters [

	image := self newImage image: self defaultIcon.
	label := self newLabel
]

{ #category : #initialization }
SpAlertDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent
]

{ #category : #api }
SpAlertDialog >> label: aString [

	label label: aString
]

{ #category : #api }
SpAlertDialog >> title [

	^ title
]

{ #category : #api }
SpAlertDialog >> title: aString [

	title := aString
]
