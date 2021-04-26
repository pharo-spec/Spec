Class {
	#name : #SpInformDialog,
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
SpInformDialog class >> defaultAcceptLabel [

	^ 'Ok'
]

{ #category : #accessing }
SpInformDialog class >> defaultExtent [

	^ 400@100
]

{ #category : #specs }
SpInformDialog class >> defaultSpec [

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
SpInformDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : #accessing }
SpInformDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : #accessing }
SpInformDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : #accessing }
SpInformDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : #initialization }
SpInformDialog >> initialize [

	super initialize.
	self title: 'Inform'
]

{ #category : #initialization }
SpInformDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.
	aDialogWindowPresenter
		addDefaultButton: self acceptLabel do: [ :presenter | presenter beOk; close ]
		
]

{ #category : #initialization }
SpInformDialog >> initializePresenters [

	image := self newImage.
	label := self newLabel.
	
]

{ #category : #initialization }
SpInformDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent
]

{ #category : #accessing }
SpInformDialog >> label: aString [

	label label: aString
]

{ #category : #accessing }
SpInformDialog >> title [

	^ title
]

{ #category : #accessing }
SpInformDialog >> title: aString [

	title := aString
]
