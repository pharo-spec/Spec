"
I am the abstract class that holds the common state and behavior of all the MessageDialogs.
"
Class {
	#name : 'SpAbstractMessageDialog',
	#superclass : 'SpDialogPresenter',
	#instVars : [
		'label',
		'title',
		'initialExtent',
		'acceptLabel'
	],
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'api' }
SpAbstractMessageDialog >> acceptLabel [

	^ acceptLabel ifNil: [ self class defaultAcceptLabel ]
]

{ #category : 'api' }
SpAbstractMessageDialog >> acceptLabel: aString [

	acceptLabel := aString
]

{ #category : 'initialization' }
SpAbstractMessageDialog >> addButtonsTo: aDialogWindowPresenter [

	aDialogWindowPresenter
		addDefaultButton: self acceptLabel
		do: [ :presenter | self accept ]
]

{ #category : 'private' }
SpAbstractMessageDialog >> adjustExtentToLabelHeight: anExtent [

	^ anExtent x @ (anExtent y - self singleLineDefaultHeight + (self calculateLabelHeightForTextWithoutMargin: label text forExtent: anExtent ))
]

{ #category : 'private' }
SpAbstractMessageDialog >> calculateLabelHeight [

	^ (self 
			calculateLabelHeightForTextWithoutMargin: label text 
			forExtent: self extent) 
		+ self labelMargin
]

{ #category : 'private' }
SpAbstractMessageDialog >> calculateLabelHeightForTextWithoutMargin: aText forExtent: anExtent [
	
	"We have a minimal height "
	aText ifEmpty: [ ^ self singleLineDefaultHeight ].

	^ (aText lineHeightsWrappingAtWidth: anExtent x - 20) sum
	
]

{ #category : 'layout' }
SpAbstractMessageDialog >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight
			add: (SpBoxLayout newTopToBottom
					vAlignStart; 
					add: image;
					yourself)
				expand: false;
			add: label expand: true;
			yourself);
		yourself
]

{ #category : 'accessing' }
SpAbstractMessageDialog >> defaultTitle [

	self subclassResponsibility 
]

{ #category : 'TOREMOVE' }
SpAbstractMessageDialog >> extent [

	^ initialExtent ifNil: [ self class defaultExtent ]
]

{ #category : 'TOREMOVE' }
SpAbstractMessageDialog >> extent: aPoint [

	initialExtent := aPoint
]

{ #category : 'initialization' }
SpAbstractMessageDialog >> initialize [

	super initialize.
	self title: self defaultTitle
]

{ #category : 'initialization' }
SpAbstractMessageDialog >> initializeDialogWindow: aDialogWindowPresenter [

	super initializeDialogWindow: aDialogWindowPresenter.

	aDialogWindowPresenter initialExtent:
		(self adjustExtentToLabelHeight: self class defaultExtent).
	self addButtonsTo: aDialogWindowPresenter
]

{ #category : 'initialization' }
SpAbstractMessageDialog >> initializePresenters [

	image := self newImage image: self defaultIcon.
	label := self newDialogLabel.
	label hide
]

{ #category : 'initialization' }
SpAbstractMessageDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: self title;
		initialExtent: self extent
]

{ #category : 'api' }
SpAbstractMessageDialog >> label: aString [

	label text: aString asText trim.
	label show
]

{ #category : 'private' }
SpAbstractMessageDialog >> labelMargin [

	^ 20
]

{ #category : 'private' }
SpAbstractMessageDialog >> newDialogLabel [

	^ self newText
		beNotEditable;
		withoutScrollBars;
		addStyle: 'textDisabled';
		propagateNaturalHeight: true;
		yourself.
]

{ #category : 'private' }
SpAbstractMessageDialog >> singleLineDefaultHeight [

	^ TextStyle defaultFont height
]

{ #category : 'TOREMOVE' }
SpAbstractMessageDialog >> title [

	^ title
]

{ #category : 'api' }
SpAbstractMessageDialog >> title: aString [

	title := aString
]
