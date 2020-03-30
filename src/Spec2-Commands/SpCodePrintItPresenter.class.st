"
I show the result of a printing as part of a popover 
"
Class {
	#name : #SpCodePrintItPresenter,
	#superclass : #SpPopoverContentPresenter,
	#instVars : [
		'object',
		'code'
	],
	#category : #'Spec2-Commands-Code'
}

{ #category : #'instance creation' }
SpCodePrintItPresenter class >> newCode: aCodePresenter object: anObject [ 

	^ (self on: anObject)
		code: aCodePresenter;
		yourself 
]

{ #category : #accessing }
SpCodePrintItPresenter >> code [

	^ code
]

{ #category : #accessing }
SpCodePrintItPresenter >> code: aCodePresenter [

	code := aCodePresenter
]

{ #category : #api }
SpCodePrintItPresenter >> dismiss [

	super dismiss.
	self code takeKeyboardFocus
]

{ #category : #actions }
SpCodePrintItPresenter >> dismissAndInspect [

	self dismiss.
	object inspect
]

{ #category : #actions }
SpCodePrintItPresenter >> dismissAndPrint [

	self dismiss.
	self code insertAndSelectAfterCurrentSelection: self objectAsPrintString
]

{ #category : #initialization }
SpCodePrintItPresenter >> initializePresenters [

	layout := SpBoxLayout newHorizontal
		spacing: 5;
		borderWidth: 5;
		add: (self newLabel
			label: self objectAsString;
			yourself);
		addLast: (self newButton 
				icon: (self application iconNamed: #smallInspectIt);
				action: [ self dismissAndInspect ];
				yourself)
			expand: false;
		addLast: (self newButton 
				icon: (self application iconNamed: #smallPrintIt);
				action: [ self dismissAndPrint ];
				yourself)
			expand: false;
		yourself.
		
	self
		bindKeyCombination: Character cr asKeyCombination toAction: [ self dismissAndPrint ];
		bindKeyCombination: Character escape asKeyCombination toAction: [ self dismiss ]
]

{ #category : #accessing }
SpCodePrintItPresenter >> objectAsPrintString [
	
	^ String streamContents: [ :stream |
		stream 
			<< ' "'
			<< self objectAsString
			<< '"' ]
]

{ #category : #accessing }
SpCodePrintItPresenter >> objectAsString [
	
	^ [ object printString ]
		on: Error
		do: [ '<error in printString: try ''Inspect it'' to debug>' ]
]

{ #category : #'accessing model' }
SpCodePrintItPresenter >> setModelBeforeInitialization: anObject [

	object := anObject
]
