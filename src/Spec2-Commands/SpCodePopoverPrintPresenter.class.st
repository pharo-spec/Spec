"
I show the result of a printing as part of a popover 
"
Class {
	#name : #SpCodePopoverPrintPresenter,
	#superclass : #SpPopoverContentPresenter,
	#instVars : [
		'object',
		'code',
		'text'
	],
	#category : #'Spec2-Commands-Code'
}

{ #category : #accessing }
SpCodePopoverPrintPresenter class >> maxLengthShownInPopover [

	^ 80
]

{ #category : #'instance creation' }
SpCodePopoverPrintPresenter class >> newCode: aCodePresenter object: anObject [ 

	^ (self on: anObject)
		code: aCodePresenter;
		yourself 
]

{ #category : #private }
SpCodePopoverPrintPresenter >> basicObjectAsString [
	
	^ [ object printString ]
		on: Error
		do: [ '<error in printString: try ''Inspect it'' to debug>' ]
]

{ #category : #accessing }
SpCodePopoverPrintPresenter >> code [

	^ code
]

{ #category : #accessing }
SpCodePopoverPrintPresenter >> code: aCodePresenter [

	code := aCodePresenter
]

{ #category : #api }
SpCodePopoverPrintPresenter >> dismiss [

	super dismiss.
	self code takeKeyboardFocus
]

{ #category : #actions }
SpCodePopoverPrintPresenter >> dismissAndInspect [

	self dismiss.
	object inspect
]

{ #category : #actions }
SpCodePopoverPrintPresenter >> dismissAndPrint [

	self dismiss.
	self code insertAndSelectAfterCurrentSelection: self objectAsPrintString
]

{ #category : #initialization }
SpCodePopoverPrintPresenter >> initializePresenters [

	self initializeText.

	layout := SpBoxLayout newHorizontal
		spacing: 5;
		borderWidth: 5;
		add: text;
		add: (SpBoxLayout newVertical
			add: (self newButton 
					icon: (self application iconNamed: #smallPrintIt);
					action: [ self dismissAndPrint ];
					yourself)
				expand: false;
			add: (self newButton 
					icon: (self application iconNamed: #smallInspectIt);
					action: [ self dismissAndInspect ];
					yourself)
				expand: false;
			yourself);
		yourself.
		
	self
		bindKeyCombination: Character cr asKeyCombination | $p meta 
			toAction: [ self dismissAndPrint ];
		bindKeyCombination: $i meta 
			toAction: [ self dismissAndInspect ];
		bindKeyCombination: Character escape asKeyCombination | Character backspace asKeyCombination
			toAction: [ self dismiss ]
]

{ #category : #initialization }
SpCodePopoverPrintPresenter >> initializeText [
	| string | 

	string := self objectAsString.
	
	text := self newText
		addStyle: 'code';
		addStyle: 'codePopover';
		propagateNaturalWidth: true;
		text: string;
		enabled: false;
		yourself.
		
	string lines size > 15 
		ifTrue: [ text addScrollBarStyle: 'scrollbarPopoverLarge' ]
]

{ #category : #accessing }
SpCodePopoverPrintPresenter >> objectAsPrintString [
	
	^ String streamContents: [ :stream |
		stream 
			<< ' "'
			<< self basicObjectAsString
			<< '"' ]
]

{ #category : #accessing }
SpCodePopoverPrintPresenter >> objectAsString [
	| string lines |
	
	string := self basicObjectAsString.
	string size <= self class maxLengthShownInPopover ifTrue: [ ^ string ].
	
	lines := string withNoLineLongerThan: self class maxLengthShownInPopover.
	^ String streamContents: [ :stream |
			lines size > 1 ifTrue: [ 
				lines := (self basicObjectAsString 
					groupsOf: self class maxLengthShownInPopover 
					atATimeCollect: [ :group | group ]) ].
			lines
				do: [ :each | stream << each ]
				separatedBy: [ stream cr ] ]
]

{ #category : #'accessing model' }
SpCodePopoverPrintPresenter >> setModelBeforeInitialization: anObject [

	object := anObject
]