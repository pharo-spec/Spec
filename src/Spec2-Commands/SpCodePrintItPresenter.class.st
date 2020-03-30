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

{ #category : #actions }
SpCodePrintItPresenter >> dismissAndInspect [

	self dismiss.
	self dismissAndPrint
]

{ #category : #actions }
SpCodePrintItPresenter >> dismissAndPrint [

	self dismiss.
	self code insertAndSelectAfterCurrentSelection: self objectAsString
]

{ #category : #initialization }
SpCodePrintItPresenter >> initializePresenters [

	layout := SpBoxLayout newHorizontal
		spacing: 10;
		add: self objectAsString "expand: false fill: false padding: 5";
		addLast: (SpButtonPresenter new 
				icon: (self application iconNamed: #glamorousInspect);
				action: [ self dismissAndInspect ];
				yourself)
			expand: false;
		yourself.
		
	self
		bindKeyCombination: Character cr asKeyCombination toAction: [ self dismissAndPrint ];
		bindKeyCombination: Character escape asKeyCombination toAction: [ self dismiss ]
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
