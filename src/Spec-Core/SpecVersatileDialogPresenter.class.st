"
A am versatile presenter for modal dialog windows with the customizable content

I have:
- title
- main message      - the basic text of the dialog 
- main icon         - the icon that is displayed next to the main message 
                      or next to the content area, if any 
- content area      - a text or another presenter with the detailed information of the dialog 
- buttons           - added using addButton:text:value
- more options text - a label of the button that shows more options of the dialog
- less options text - a label of the button that shows more options of the dialog in case
                      that the options are visible
- footnote icon     - an icon that is displayed next to the footnote 
- footnote area     - a text or another presenter with the footnote

"
Class {
	#name : #SpecVersatileDialogPresenter,
	#superclass : #DynamicComposablePresenter,
	#instVars : [
		'mainMessage',
		'mainIcon',
		'contentArea',
		'buttons',
		'moreOptionsButton',
		'moreOptionsText',
		'lessOptionsText',
		'moreOptionsArea',
		'footnoteIcon',
		'footnoteArea',
		'moreOptionsVisible',
		'mainMessagePresenter',
		'mainIconPresenter',
		'contentAreaPresenter',
		'moreOptionsAreaPresenter',
		'footnoteIconPresenter',
		'footnoteAreaPresenter',
		'result'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
SpecVersatileDialogPresenter class >> example1 [ 

	<example>
	
	| dialog |
	
	dialog := SpecVersatileDialogPresenter new.
	dialog title: 'Confirmation'.
	dialog mainMessage: 'Confirm your choice' asText allBold.
	dialog mainIcon: (self iconNamed: #question).
	dialog contentArea: 'Do you want to discard your content?'.
	dialog moreOptionsArea: (dialog newCheckBox label: 'Discard permanently').
	dialog addButton: #yes text: 'yes' value: #yes.
	dialog addButton: #no text: 'no' value: #no.
	dialog addButton: #cancel text: 'cancel' value: #cancel.
	dialog footnoteIcon: (self iconNamed: #error).
	dialog footnoteArea: 'This operation can be very dangerous.'.
	dialog openModalWithSpec.
	dialog result logCr.

	self inform: (dialog moreOptionsArea state asString).


]

{ #category : #specs }
SpecVersatileDialogPresenter class >> example2 [

	<example>
	
	| dialog |
	
	dialog := SpecVersatileDialogPresenter new.
	dialog title: 'Confirmation'.
	dialog mainMessage: 'Save content' asText allBold.
	dialog addButton: #save text: 'Save' value: true.
	dialog addButton: #cancel text: 'Cancel' value: false.
	dialog mainIcon: (self iconNamed: #question).
	
	dialog openModalWithSpec.

	dialog result logCr.




]

{ #category : #specs }
SpecVersatileDialogPresenter class >> example3 [

	<example>
	
	| dialog |
	
	dialog := SpecVersatileDialogPresenter new.
	dialog title: 'Confirmation'.
	dialog mainMessage: 'Save content' asText allBold.
	dialog addButton: #save text: 'Save' value: true.
	dialog addButton: #cancel text: 'Cancel' value: false.
	dialog mainIcon: (self iconNamed: #question).
	
	(dialog buttonAt: #save) icon: (self iconNamed: #smallSave).
	dialog footnoteIcon: (self iconNamed: #error).
	dialog footnoteArea: 'Saving may take several minutes'.
	
	dialog openModalWithSpec.
	dialog result logCr.

	



]

{ #category : #specs }
SpecVersatileDialogPresenter class >> example4 [

	<example>
	
	| dialog |
	
	dialog := SpecVersatileDialogPresenter new.
	dialog title: 'Select mumber'.
	1 to: 5 do: [ :aNumber |
		dialog addButton: ('button', aNumber asString) asSymbol 
			text: aNumber printStringRoman 
			value: aNumber ].
	
	dialog openModalWithSpec.
	dialog result logCr.

	



]

{ #category : #initialization }
SpecVersatileDialogPresenter >> addButton: id text: buttonText value: anObject [

	| aButton |
	
	aButton := self newButton label: buttonText.
	aButton action: [ self return: anObject ].

	buttons at: id put: aButton.

	self additionalSubpresentersMap at: id put: aButton.
	
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> buttonAt: id [

	^ buttons at: id
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> buttons [

	^ buttons
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> contentArea [

	^ contentArea
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> contentArea: aTextOrPresenter [

	contentArea := aTextOrPresenter.
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> footnoteArea [

	^ footnoteArea
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> footnoteArea: aTextOrPresenter [

	footnoteArea := aTextOrPresenter.
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> footnoteIcon [

	^ footnoteIcon
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> footnoteIcon: aForm [

	footnoteIcon := aForm.
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> hasFootnote [

	^ false
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> initialExtent [
	^ 400@200
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> initialize [

	super initialize.
	
	moreOptionsVisible := false.
	buttons := OrderedDictionary new.
	result := nil.

]

{ #category : #initialization }
SpecVersatileDialogPresenter >> initializeDialogWindow: aDialogWindowPresenter [
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> initializePresenter [ 

	super initializePresenter.
	
	moreOptionsButton action: [ 
		moreOptionsVisible := moreOptionsVisible not.
		self needRebuild: false.
		self buildWithSpec ].
	

]

{ #category : #initialization }
SpecVersatileDialogPresenter >> initializeWidgets [ 

	moreOptionsText := 'More options' asText.
	lessOptionsText := 'Less options' asText.
	moreOptionsButton := self newButton label: moreOptionsText.
	
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> layout [

	| mainLayout |
	
	mainLayout := SpecLayout composed.
	
	mainLayout newColumn: [ :column | 

		"if the content area is not defined, place main message next to the main icon"
		contentArea ifNotNil: [ 
			mainMessage ifNotNil: [
				mainMessagePresenter := (mainMessage isString or: [ mainMessage isText ]) 
					ifTrue: [ self newLabel label: mainMessage ]
					ifFalse: [ mainMessage ].
				column add: #mainMessagePresenter ] ].
		
		column newRow: [ :row |		
		mainIcon ifNotNil: [ 
			mainIconPresenter := self newImage image: self mainIcon.
			row add: #mainIconPresenter width: (self mainIcon width * 2) ]	.
		
		contentArea 
			ifNotNil: [
				contentAreaPresenter := (contentArea isString or: [ contentArea isText ]) 
					ifTrue: [ self newLabel label: contentArea ]
					ifFalse: [ contentArea ].
				row add: #contentAreaPresenter ]
			ifNil: [ 
				mainMessage ifNotNil: [
				mainMessagePresenter := (mainMessage isString or: [ mainMessage isText ]) 
					ifTrue: [ self newLabel label: mainMessage ]
					ifFalse: [ mainMessage ].
				row add: #mainMessagePresenter ]  ] ].

		column newRow: [ :row |	
			moreOptionsArea ifNotNil: [
				moreOptionsButton label: (moreOptionsVisible
					ifFalse: [ ('↓ ', self moreOptionsText) ]
					ifTrue: [ ('↑ ', self lessOptionsText) ]).
				
				row add: #moreOptionsButton.
				moreOptionsAreaPresenter := (moreOptionsArea isString or: [ moreOptionsArea isText ]) 
					ifTrue: [ self newLabel label: moreOptionsArea ]
					ifFalse: [ moreOptionsArea ]] .	
			buttons keysAndValuesDo: [ :buttonKey :aButton |
				row add: buttonKey ]].
		
		moreOptionsVisible ifTrue: [ 
			column add: #moreOptionsAreaPresenter ].
		
		footnoteArea ifNotNil: [
			column newRow: [ :row |	
				footnoteIcon ifNotNil: [ 
					footnoteIconPresenter := self newImage image: footnoteIcon.
					row add: #footnoteIconPresenter width: (self footnoteIcon width * 2) ]	.
			
					footnoteAreaPresenter := (footnoteArea isString or: [ footnoteArea isText ]) 
						ifTrue: [ self newLabel label: footnoteArea ]
						ifFalse: [ footnoteArea ].
					row add: #footnoteAreaPresenter ] ] ].
	
	^ mainLayout
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> lessOptionsText [

	^ lessOptionsText
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> lessOptionsText: aText [

	lessOptionsText := aText.
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> mainIcon [

	^ mainIcon
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> mainIcon: aFrom [

	mainIcon := aFrom
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> mainMessage [

	^ mainMessage
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> mainMessage: aTextOrPresenter [

	mainMessage := aTextOrPresenter.
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> moreOptionsArea [

	^ moreOptionsArea
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> moreOptionsArea: aTextOrPresenter [

	moreOptionsArea := aTextOrPresenter.
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> moreOptionsText [

	^ moreOptionsText
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> moreOptionsText: aText [

	moreOptionsText := aText.
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> result [

	^ result
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> result: anObject [

	result := anObject
]

{ #category : #initialization }
SpecVersatileDialogPresenter >> return: anObject [

	self result: anObject.
	self window close.
]
