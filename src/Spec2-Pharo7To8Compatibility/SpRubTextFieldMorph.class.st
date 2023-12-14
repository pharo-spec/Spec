Class {
	#name : 'SpRubTextFieldMorph',
	#superclass : 'RubScrolledTextMorph',
	#instVars : [
		'hasValidText',
		'acceptOnCR',
		'entryCompletion',
		'maxLength',
		'askBeforeDiscardingEdits',
		'getBackgroundColorSelector'
	],
	#category : 'Spec2-Pharo7To8Compatibility',
	#package : 'Spec2-Pharo7To8Compatibility'
}

{ #category : 'instance creation' }
SpRubTextFieldMorph class >> on: aModel [ 
	^ self new on: aModel
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> accept [
	self acceptContents.
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> acceptContents [
	(self autoAccept not and: [ self canDiscardEdits and: [ self alwaysAccept not ] ])
		ifTrue: [ ^ self flash ].
	self hasEditingConflicts
		ifTrue: [ (self
				confirm:
					'Caution! This method may have been
changed elsewhere since you started
editing it here.  Accept anyway?' translated)
				ifFalse: [ ^ self flash ] ].
	self acceptTextInModel == true
		ifFalse: [ ^ self ].
	self hasUnacceptedEdits: false.
	self rulers do: [ :r | r textAccepted ].
	self announcer announce: (RubTextAccepted morph: self)
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> acceptOnCR [
	^ acceptOnCR 
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> acceptOnCR: aBoolean [
	acceptOnCR := aBoolean
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> acceptTextInModel [
	"Inform the model that the receiver's textArea text should be accepted.
	Answer true if the model accepted ok, something else otherwise (sic)"
	| result |
	self model ifNil: [ ^ true ].
	 result :=  self setTextSelector numArgs = 2
		ifTrue: [ self model perform: self setTextSelector with: self text with: self ]
		ifFalse: [ self model perform: self setTextSelector withEnoughArguments: (Array with: self text) ].
		
	"Yes, we check here with == instead of with #ifTrue:. 
	That's bad but  some models don't return true of false"
	result == true ifTrue: [ self closeChooser ].
	^ result

]

{ #category : 'accessing segments' }
SpRubTextFieldMorph >> addSegment: aRubTextSegmentMorph [
	^ self textArea addSegment: aRubTextSegmentMorph

]

{ #category : 'drawing' }
SpRubTextFieldMorph >> adornmentColor [
	"color to Indicate edit status for the given morph."

	self hasValidText
		ifFalse: [ ^ Color red ].
	self hasEditingConflicts
		ifTrue: [ ^ Color red ].
	self hasUnacceptedEdits
		ifTrue: [ ^ Color orange ].
	^ Color transparent
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> adornmentRuler [
	^ self rulerNamed: #adornment
]

{ #category : 'accessing menu' }
SpRubTextFieldMorph >> allowMenu [
	self menuAllowed: true
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> alwaysAccept [
	^ alwaysAccept ifNil: [ alwaysAccept := false]
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> alwaysAccept: aBoolean [
	"Set the always accept flag."
	"This flag is used when there are unsaved changes in my text field and an exterior actor tries to modify me"
	"If the flag is true, I will accept to change even if I have pending modification instead of poping up the Accept/Discard/Cancel window"


	alwaysAccept := aBoolean
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> annotationRuler [
	^ self rulerNamed: #annotation
]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> appendText: stringOrText [
	"Accept new text contents with line breaks only as in the text.
	Fit my width and height to the result."

	self scrollPane appendText: stringOrText.	
	self resetState
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> askBeforeDiscardingEdits: aBoolean [
	"Set the flag that determines whether the user should be asked before discarding unaccepted edits."

	askBeforeDiscardingEdits := aBoolean
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> autoAccept [
	"Answer whether the editor accepts its contents on each change."

	^autoAccept ifNil: [autoAccept := false]
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> autoAccept: aBoolean [
	"Whether I should accept my contents on each change."
	autoAccept := aBoolean.
	aBoolean
		ifTrue: [ self withoutAdornment]
		ifFalse: [ self withAdornment ]
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> backgroundColor [
	^self scrollPane color
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> backgroundColor: aColor [
	self scrollPane color: aColor
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> basicHasUnacceptedEdits: aBoolean [
	self autoAccept
		ifTrue: [ ^ self ].
	aBoolean = hasUnacceptedEdits 
		ifFalse: [ hasUnacceptedEdits := aBoolean.
			self changed].
	aBoolean 
		ifFalse: [hasEditingConflicts := false]
]

{ #category : 'encryption' }
SpRubTextFieldMorph >> beDecrypted [

	self textMorph font: TextStyle defaultFont.
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> beEditable [
	self textArea beEditable 
]

{ #category : 'encryption' }
SpRubTextFieldMorph >> beEncrypted [

	self textMorph font: (StrikeFont passwordFontSize: self theme textFont pointSize).
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> beForPlainText [
	self textArea beForPlainText
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> beForSmalltalkCode [
	self textArea beForSmalltalkCode.
	self withTextSegmentIcons.
	self textArea font: StandardFonts codeFont
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> beForSmalltalkCodeInClass: aClass [
	self textArea beForSmalltalkCodeInClass: aClass.
	self withTextSegmentIcons.
	self textArea font: StandardFonts codeFont
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> beForSmalltalkCodeWithDefaultFont [
	self textArea beForSmalltalkCodeWithDefaultFont.
	self withTextSegmentIcons
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> beForSmalltalkComment [
	self textArea beForSmalltalkComment
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> beForSmalltalkScripting [
    self textArea beForSmalltalkScripting.
    self textArea font: StandardFonts codeFont

]

{ #category : 'accessing' }
SpRubTextFieldMorph >> beForSmalltalkScriptingWithDefaultFont [
    self textArea beForSmalltalkScriptingWithDefaultFont

]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> beNotWrapped [
	self scrollPane beNotWrapped 
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> beReadOnly [
	self textArea beReadOnly 
]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> beWrapped [
	self scrollPane beWrapped
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> borderStyleToUse [
	"Answer the borderStyle that should be used for the receiver."
	
	^self enabled
		ifTrue: [self theme rubScrolledTextMorphThemer normalBorderStyleFor: self]
		ifFalse: [self theme rubScrolledTextMorphThemer disabledBorderStyleFor: self]
]

{ #category : 'accessing scrollbars' }
SpRubTextFieldMorph >> borderWidth: anInteger [
	super borderWidth: anInteger.
	self extent: self extent.
	self manageLayout 
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> canDiscardEdits [
	^ (self hasUnacceptedEdits and: [askBeforeDiscardingEdits]) not

]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> cancel [

	self updateTextWith: self getTextFromModel.
	self setSelection: self getSelectionFromModel
]

{ #category : 'testing' }
SpRubTextFieldMorph >> chooserHasFocus [
	^ self chooserIsOpened and: [entryCompletion chooser hasKeyboardFocus]
]

{ #category : 'testing' }
SpRubTextFieldMorph >> chooserIsOpened [
	^ entryCompletion notNil and: [entryCompletion chooser notNil]
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> classOfRulerNamed: aKey [
	^ RubScrolledTextExtra classOfRulerNamed: aKey
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> classOrMetaClass: aBehavior [
	self textArea classOrMetaClass: aBehavior
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> closeChooser [	
	entryCompletion
		ifNotNil: [entryCompletion closeChooser]
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> columnRuler [
	^ self rulerNamed: #column
]

{ #category : 'configure' }
SpRubTextFieldMorph >> configureGhostText: aTextArea [
	aTextArea width: self scrollBounds width.
	aTextArea center: self scrollBounds center.
	self hasKeyboardFocus
		ifTrue: [ 
			aTextArea left: self left]
]

{ #category : 'interactive error protocol' }
SpRubTextFieldMorph >> correctFrom: start to: stop with: aString [
	self textArea correctFrom: start to: stop with: aString
]

{ #category : 'accessing scrollbars' }
SpRubTextFieldMorph >> currentHScrollBarThickness [
	^self scrollPane currentHScrollBarThickness
]

{ #category : 'accessing text area' }
SpRubTextFieldMorph >> cursor [
	"polymorphism with text area"
	^ self textArea cursor
]

{ #category : 'defaults' }
SpRubTextFieldMorph >> defaultBackgroundColor [ 
	^ self theme backgroundColor
]

{ #category : 'defaults' }
SpRubTextFieldMorph >> defaultBorderWidth [
	^ 0
]

{ #category : 'defaults' }
SpRubTextFieldMorph >> defaultColor [
	^ self defaultBackgroundColor 
]

{ #category : 'defaults' }
SpRubTextFieldMorph >> defaultGhostTextMorph [
	| gt |
	gt := RubEditingArea new.
	gt withoutAnyDecorator.
	gt backgroundColor: Color transparent.
	gt beReadOnly.
	gt beWrapped.
	^ gt beNotWrapped 
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> defaultScrollTarget [
	| textArea |
	textArea := self textAreaClass new.
	textArea backgroundColor: Color lightGray veryMuchLighter.
	^ textArea
]

{ #category : 'protocol' }
SpRubTextFieldMorph >> disable [
	self beReadOnly 
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> drawFocusBorder [
	^ self scrollPane drawFocusBorder
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> drawFocusBorder: aBoolean [
	self scrollPane drawFocusBorder: aBoolean
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> drawHighlightsOn: aCanvas [
	"Draw the highlights."

	| scrollBounds scrollOffset |
	
	scrollBounds := self scrollPane innerBounds.
	scrollOffset := self scrollPane scroller offset.
	
	aCanvas clipBy: self clippingBounds during: [ :canvas | 
		self highlights do: [ :highlight | 
			highlight drawOn: canvas in: scrollBounds offset: scrollOffset 
		] 
	]
]

{ #category : 'drawing' }
SpRubTextFieldMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
	self drawHighlightsOn: aCanvas 
]

{ #category : 'drawing' }
SpRubTextFieldMorph >> drawOnAthensCanvas: anAthensCanvas [
	"Indicate unaccepted edits, conflicts etc."

	super drawOnAthensCanvas: anAthensCanvas. 
	self drawHighlightsOn: anAthensCanvas asCanvasWrapper
]

{ #category : 'drawing' }
SpRubTextFieldMorph >> drawSubmorphsOn: aCanvas [
	"Display submorphs back to front"

	| drawBlock subs |
	submorphs isEmpty
		ifTrue: [ ^ self ].
	subs := submorphs copyWithoutAll: self sideRulers.
	drawBlock := [ :canvas | subs reverseDo: [ :m | canvas fullDrawMorph: m ] ].
	self clipSubmorphs
		ifTrue: [ aCanvas clipBy: (aCanvas clipRect intersect: self clippingBounds ifNone: [ ^ self ]) during: drawBlock ]
		ifFalse: [ drawBlock value: aCanvas ].
	subs := self sideRulers.
	drawBlock := [ :canvas | subs reverseDo: [ :m | canvas fullDrawMorph: m ] ].
	self clipSubmorphs
		ifTrue: [ aCanvas clipBy: (aCanvas clipRect intersect: self clippingBounds ifNone: [ ^ self ]) during: drawBlock ]
		ifFalse: [ drawBlock value: aCanvas ]
]

{ #category : 'drawing' }
SpRubTextFieldMorph >> drawSubmorphsOnAthensCanvas: anAthensCanvas [
	"Display submorphs back to front"

	| drawBlock subs |
	submorphs isEmpty
		ifTrue: [ ^ self ].
	subs := submorphs copyWithoutAll: self sideRulers.
	drawBlock := [ subs reverseDo: [ :m | anAthensCanvas fullDrawMorph: m ] ].
	self clipSubmorphs
		ifTrue: [ anAthensCanvas clipBy: (anAthensCanvas clipRect intersect: self clippingBounds ifNone: [ ^ self ]) during: drawBlock ]
		ifFalse: [ drawBlock value ].
	subs := self sideRulers.
	drawBlock := [ subs reverseDo: [ :m | anAthensCanvas fullDrawMorph: m ] ].
	self clipSubmorphs
		ifTrue: [ anAthensCanvas clipBy: (anAthensCanvas clipRect intersect: self clippingBounds ifNone: [ ^ self ]) during: drawBlock ]
		ifFalse: [ drawBlock value ]
]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> editPrimarySelectionSeparately [
	self textArea editPrimarySelectionSeparately
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> editingMode [
	^  self textArea editingMode
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> editingMode: anEditingMode [
	self textArea editingMode: anEditingMode.

]

{ #category : 'accessing' }
SpRubTextFieldMorph >> editingModeClass [
	^ self textArea editingMode class
]

{ #category : 'mock for spec' }
SpRubTextFieldMorph >> enabled: aBoolean [
	enabled = aBoolean ifTrue: [^self].
	enabled := aBoolean.
	self textArea readOnly: aBoolean not.
	self changed
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> encrypted: aBoolean [

	aBoolean
		ifTrue: [ self beEncrypted ]
		ifFalse: [ self beDecrypted ]
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> entryCompletion [ 
	^ entryCompletion 
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> entryCompletion: anEntryCompletion [
	entryCompletion := anEntryCompletion.
	entryCompletion
		ifNil: [ self withoutDropListButton ]
		ifNotNil: [ 
			self withDropListButton.
			entryCompletion chooseBlock isNil
			ifTrue: [entryCompletion chooseBlock: [:v | self setText: v. self acceptTextInModel ]]
			ifFalse: [ | blk | 
				blk := entryCompletion chooseBlock.
				entryCompletion chooseBlock: [:v | self setText: v. self acceptTextInModel. blk value: v]]].

]

{ #category : 'geometry' }
SpRubTextFieldMorph >> extent: aPoint [
	super extent: aPoint x @ self textFieldHeight.
	self manageLayout
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> extraAreas [
	^ self rulers select: [ :r | r isOver ]

]

{ #category : 'focus' }
SpRubTextFieldMorph >> focusChanged [
	(self hasFocus or: [self chooserHasFocus])
		ifFalse: [self closeChooser].
	super focusChanged

]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> font [
	^ self textArea font
]

{ #category : 'accessing text area' }
SpRubTextFieldMorph >> font: aFont [
	"polymorphism with text area"
	self textFont: aFont
]

{ #category : 'accessing menu' }
SpRubTextFieldMorph >> forbidMenu [
	self menuAllowed: false
]

{ #category : 'formatting' }
SpRubTextFieldMorph >> formatSourceCode [
	self textArea formatMethodCode
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> getBackgroundColorFromModel [
	"Retrieve the color from the model"

	self getBackgroundColorSelector ifNil: [^ self ].
	^ self model perform: self getBackgroundColorSelector withEnoughArguments: {self}.
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> getBackgroundColorSelector [ 
	^ getBackgroundColorSelector 
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> getBackgroundColorSelector: aSelector [
	getBackgroundColorSelector := aSelector
]

{ #category : 'accessing menu' }
SpRubTextFieldMorph >> getMenuPolicy: aGetMenuPolicy [
	self textArea getMenuPolicy: aGetMenuPolicy
]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> getSelectionFromModel [
	"Answer the model's selection interval."

	^ self getSelectionSelector ifNotNil: [ :s | self model perform: s withEnoughArguments: {self} ]
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> getSelectionSelector [
	^ getSelectionSelector
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> getSelectionSelector: aSelector [
	getSelectionSelector := aSelector.

]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> getText [
	"Retrieve the current view text, possibly not accepted"

	^ self textArea text
]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> getTextFromModel [
	"Retrieve the current model text"

	| newText |
	self getTextSelector ifNil: [^Text new].
	newText := (self model perform: self getTextSelector withEnoughArguments: {self}).
	newText ifNil: [^Text new].
	^newText copy asText
]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> getTextFromView [
	"Retrieve the current view text, possibly not accepted"

	^ self textArea text
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> getTextSelector [
	^ getTextSelector ifNil: [  getTextSelector := #getText ]
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> getTextSelector: aSymbol [ 
	getTextSelector  := aSymbol
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> ghostText [
	^ (self rulerNamed: #ghostText) ghostText text
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> ghostText: aText [
	self withGhostText: aText
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> ghostTextRuler [
	^ self rulerNamed: #ghostText
]

{ #category : 'accessing scrollbars' }
SpRubTextFieldMorph >> hScrollbarShowAlways [
	self scrollPane hScrollbarShowAlways.
	self extent: self extent.
	self manageLayout 
]

{ #category : 'accessing scrollbars' }
SpRubTextFieldMorph >> hScrollbarShowNever [
	self scrollPane hScrollbarShowNever
]

{ #category : 'accessing scrollbars' }
SpRubTextFieldMorph >> hScrollbarShowWhenNeeded [
	self scrollPane hScrollbarShowWhenNeeded
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> handleMouseDown: event [
	^ super handleMouseDown: event
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> handlesKeyboard: evt [
	"Yes for page up/down."
	
	^true
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> handlesMouseDown: event [
	^ self scrollBounds containsPoint: event cursorPoint
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> handlesMouseWheel: evt [
	"Do I want to receive mouseWheel events?" 

	^ true
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> hasEditingConflicts [
	^ hasEditingConflicts
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> hasEditingConflicts: aBoolean [
	hasEditingConflicts := aBoolean
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> hasKeyboardFocus [
	^ (self scrollPane ifNil: [ ^false ]) hasKeyboardFocus
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> hasRuler: aRuler [
	^ self rulers includes: aRuler
	
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> hasRulerNamed: aKey [
	^ self rulers anySatisfy: [ :r | r key = aKey ]
	
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> hasUnacceptedEdits [
	^ hasUnacceptedEdits
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> hasUnacceptedEdits: aBoolean [
	"Set the hasUnacceptedEdits flag to the given value. "
	
	(self model respondsTo: #hasUnacceptedEdits:)
		ifTrue: [ self model hasUnacceptedEdits: aBoolean ]
		ifFalse: [ self basicHasUnacceptedEdits: aBoolean ]
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> hasValidText [
	^ hasValidText
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> hasValidText: aBoolean [
	hasValidText := aBoolean
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> highlights [
	^ highlights
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> highlights: anObject [
	highlights := anObject
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> horizontalRulers [
	^self rulers select: [ :r | r isHorizontal ]
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> initialize [
	super initialize.
	self clipSubmorphs: true.
	enabled := true.
	askBeforeDiscardingEdits := true.
	hasEditingConflicts := false.
	hasUnacceptedEdits := false.
	rulers := SortedCollection sortBlock: [ :a :b | b level > a level ].
	self addMorph: (scrollPane := self newScrollPane).
	self announcer when: RubConfigurationChange send: #whenConfigurationChanged: to: self.
	self textArea announcer when: RubCancelEditRequested send: #whenCancelEditRequested: to: self.
	self textArea announcer when: MorphGotFocus send: #whenGotForcus: to: self.
	self textArea announcer when: MorphLostFocus send: #whenLostFocus: to: self.
	self textArea announcer when: RubTextAcceptRequest send: #whenTextAcceptRequest: to: self.
	self textArea announcer when: RubTextChanged send: #whenTextChangedInTextArea: to: self.
	self textArea announcer when: RubReturnEntered send: #whenReturnEnteredInTextArea: to: self.
	self textArea announcer when: RubKeystroke send: #whenKeystrokeInTextArea: to: self.
	self withAdornment.
	self borderStyle: self borderStyleToUse.
	highlights := OrderedCollection new.
	hasValidText := true.
	self textArea announcer when: RubReturnEntered  send: #whenReturnEntered: to: self.
	self scrollbarsShowNever.
	self extent: self extent.
	acceptOnCR := true.
	maxLength := 0.
	self beDecrypted
]

{ #category : 'testing' }
SpRubTextFieldMorph >> isReadOnly [
	^ self textArea isReadOnly 
]

{ #category : 'classification' }
SpRubTextFieldMorph >> isRenderer [
	^ true
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> keyStroke: event [
	self scrollPane
		ifNotNil: [ :scrollpane | scrollpane keyStroke: (event transformedBy: (scrollpane transformFrom: self)) ]
]

{ #category : 'focus' }
SpRubTextFieldMorph >> keyboardFocusChange: aBoolean [
	self closeChooser.
	super keyboardFocusChange: aBoolean.

]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> lineNumbersRuler [
	^ self rulerNamed: #lineNumbers
]

{ #category : 'layout' }
SpRubTextFieldMorph >> manageLayout [
	| ret |
	self textArea ifNil: [ ^self ].
	ret := self manageLayoutInBounds: self innerBounds.
	self layoutChanged.
	^ret
]

{ #category : 'defaults' }
SpRubTextFieldMorph >> manageLayoutInBounds: aRectangle [
	| myBounds |
	myBounds := aRectangle.
	self horizontalRulers do: [ :r | myBounds := r manageLayoutInBounds: myBounds ].
	self verticalRulers do: [ :r | myBounds := r manageLayoutInBounds: myBounds ].
	self overRulers do: [ :r | myBounds := r manageLayoutInBounds: myBounds ].
	self scrollPane
		ifNotNil: [ :scrollpane |
			scrollpane position: myBounds topLeft.
			scrollpane extent: (myBounds extent max: 0@0)].
	self closeChooser 
]

{ #category : 'accessing text area' }
SpRubTextFieldMorph >> margins: aMargin [
	"polymorphism with text area"
	self textArea margins: aMargin
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> maxLength [
	
	"Returns the max length of this text field.
	0 meaning unlimited"
	^ maxLength
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> maxLength: anInteger [
	"Sets the max length of the text field.
	0 means unlimited"
	maxLength := anInteger.
	maxLength = 0 ifTrue: [ ^ self ].
	
	"If the contents of this textfield exceed the max length, contents are truncated"
	self getText size > maxLength
		ifTrue: [ self setText: (self getText first: maxLength) ]
]

{ #category : 'accessing menu' }
SpRubTextFieldMorph >> menuAllowed: aBoolean [
	self textArea menuAllowed: aBoolean
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> menuProvider: anObject selector: aSelector [
	self textArea
		getMenuPolicy:
			(RubPluggableGetMenuPolicy new
				getMenuSelector: aSelector;
				menuProvider: anObject;
				yourself)
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> model [ 
	^self textArea model
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> model: aModel [
	self textArea model: aModel.
	self setTextWith: self getTextFromModel.
	self setSelection: self getSelectionFromModel.
	aModel announcer when: RubTextAcceptedInModel send: #whenTextAcceptedInModel: to: self.	
	aModel announcer when: RubEditsStateChangedInModel send: #whenEditsStateChangedInModel: to: self.
	aModel announcer when: RubTextSetInModel send: #whenTextSetInModel: to: self.	
	aModel announcer when: RubTextUpdatedInModel send: #whenTextUpdatedInModel: to: self.	
	aModel announcer when: RubPrimarySelectionUpdatedInModel send: #whenPrimarySelectionUpdatedInModel: to: self.
	aModel announcer when: RubCancelEditRequestedInModel send: #whenCancelEditRequestedInModel: to: self.	
	aModel announcer when: RubConfigurationChange send: #whenConfigurationChangedFromModel: to: self.

]

{ #category : 'event handling' }
SpRubTextFieldMorph >> mouseDown: event [
	"If pane is not empty, pass the event to the last submorph,
	assuming it is the most appropriate recipient (!)"

	(self innerBounds containsPoint: event cursorPoint)
		ifTrue: [ 
			self scrollPane mouseDown: event.
			self eventHandler ifNotNil: [ self eventHandler mouseDown: event fromMorph: self ] ]
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> mouseWheel: event [ 
	"Handle a mouseWheel event."
	
	(self scrollPane scrollTarget handlesMouseWheel: event)
		ifTrue: [^self scrollTarget mouseWheel: event]. "pass on"
]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> moveCursorToIndex: anIndex [ 
	self selectFrom: anIndex to: anIndex - 1
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> newScrollPane [
	| sp |
	sp := RubTextScrollPane new.
	sp scrollTarget: self defaultScrollTarget.
	^ sp
]

{ #category : 'submorphs-accessing' }
SpRubTextFieldMorph >> noteNewOwner: aMorph [ 
	super noteNewOwner: aMorph.
	self manageLayout 
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> notificationStrategy: aStrategy [
	self textArea notificationStrategy: aStrategy
]

{ #category : 'interactive error protocol' }
SpRubTextFieldMorph >> notify: message at: location in: code [
	^ self textArea notify: message at: location in: code
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> offset [
	^ self scrollPane offset
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> on: aModel [ 
	self model: aModel.

]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> on: aModel text: aGetTextSelector accept: aSetTextSelector readSelection: aReadSelectionSelector menu: aGetMenuSelector [
	self getTextSelector: aGetTextSelector.
	self setTextSelector: aSetTextSelector.
	self getSelectionSelector: aReadSelectionSelector.
	aGetMenuSelector
		ifNil: [ self textArea forbidMenu ]
		ifNotNil: [ self menuProvider: aModel selector: aGetMenuSelector ].
	self on: aModel
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> on: anObject text: getTextSel accept: setTextSel readSelection: getSelectionSel menu: getMenuSel setSelection: setSelectionSel [
	self
		on: anObject
		text: getTextSel
		accept: setTextSel
		readSelection: getSelectionSel
		menu: getMenuSel.
	setSelectionSelector := setSelectionSel.
	self borderWidth: 1.
	self setText: self getTextFromModel.
	self setSelection: self getSelectionFromModel
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> openChooser [	
	entryCompletion
		ifNotNil: [
			entryCompletion openChooserWith: self textArea text string from: self]
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> outOfWorld: aWorld [
	self closeChooser.
	super outOfWorld: aWorld
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> overRulers [
	^self rulers select: [ :r | r isOver ]
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> paragraph [
	^ self scrollPane paragraph 
]

{ #category : 'geometry' }
SpRubTextFieldMorph >> position: aPoint [
	super position: aPoint.
	self manageLayout

	
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> removeAllRulers [
	[ self rulers notEmpty ] whileTrue: [ self withoutRuler: self rulers first ]
]

{ #category : 'private' }
SpRubTextFieldMorph >> resetState [
	hasValidText := true.
		hasEditingConflicts := false.
	hasUnacceptedEdits := false.
	self changed
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> rulerNamed: aKey [
	^self rulers detect: [ :r | r key = aKey ] ifNone: [  ]
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> rulers [
	^ rulers 
]

{ #category : 'geometry' }
SpRubTextFieldMorph >> scrollBounds [
	^ self scrollPane scrollBounds
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> scrollPane [
	^ scrollPane
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> scrollToBeginningOfLine [
	self scrollPane scrollToBeginningOfLine
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> scrollToBeginningOfText [
	self scrollPane scrollToBeginningOfText
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> scrollToEndOfLine [
	self scrollPane scrollToEndOfLine
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> scrollToEndOfText [
	self scrollPane scrollToEndOfText
]

{ #category : 'accessing scrollbars' }
SpRubTextFieldMorph >> scrollbarsShowNever [
	self hScrollbarShowNever.
	self vScrollbarShowNever
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> scrollerExtentChanged [
	self manageLayout

]

{ #category : 'accessing scrollbars' }
SpRubTextFieldMorph >> scrollerOffsetChanged [
	self rulers do: [:r | r scrollerOffsetChanged]
]

{ #category : 'accessing segments' }
SpRubTextFieldMorph >> segments [
	^ self textArea segments

]

{ #category : 'accessing segments' }
SpRubTextFieldMorph >> segmentsAtLine: aLineNumber [
	^ self textArea  segmentsAtLine: aLineNumber

]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> selectAll [
	self selectFrom: 1 to: self text size 
]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> selectFrom: firstIndex to: lastIndex [
	self selectionInterval: (firstIndex to: lastIndex)

]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> selectionChanged [
	self rulers do: [ :r | r selectionChanged ].
	self setModelSelection: self selectionInterval

]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> selectionInterval [
	^ self textArea selectionInterval
]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> selectionInterval: anInterval [
	self setSelection: anInterval
]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> setModelSelection: aSelectionInterval [
	"try to set the selection in the model"
	setSelectionSelector
		ifNotNil: [ self model perform: setSelectionSelector with: aSelectionInterval]
]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> setSelection: aSelectionInterval [
	aSelectionInterval ifNil: [ ^ self ].
	self setTextAreaSelection: aSelectionInterval.
	self selectionChanged 
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> setSelectionSelector: aSelector [
	setSelectionSelector := aSelector
]

{ #category : 'mock for spec' }
SpRubTextFieldMorph >> setText: aText [
	self updateTextWith: aText
]

{ #category : 'accessing-selection' }
SpRubTextFieldMorph >> setTextAreaSelection: aSelectionInterval [
	aSelectionInterval ifNil: [ ^ self ].
	self textArea selectFrom: aSelectionInterval first to: aSelectionInterval last.
	self scrollPane scrollSelectionIntoView
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> setTextSelector [
	^ setTextSelector ifNil: [  setTextSelector := #setText:from:]
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> setTextSelector: aSymbol [ 
	setTextSelector  := aSymbol
]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> setTextWith: stringOrText [
	"Accept new text contents with line breaks only as in the text.
	Fit my width and height to the result."
	self scrollPane setTextWith: stringOrText.
	self setSelection: self getSelectionFromModel.
	self resetState
]

{ #category : 'private' }
SpRubTextFieldMorph >> shoutStyler [
	^ self textArea shoutStyler
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> sideRulers [
	^self rulers select: [ :r | r isSideRuler ]
]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> tabWidth [
	^ self textArea tabWidth
]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> tabWidth: anInteger [
	self textArea tabWidth: anInteger 
]

{ #category : 'model protocol' }
SpRubTextFieldMorph >> takeKeyboardFocus [
	self textArea takeKeyboardFocus
]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> text [
	^ self textArea text
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> textArea [
	^ self scrollPane ifNotNil: [:sp | sp textArea]
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> textAreaClass [
	^ RubTextFieldArea
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> textAreaExtentChanged [
	self manageLayout

]

{ #category : 'event handling' }
SpRubTextFieldMorph >> textChanged [
	self manageLayout.
	self autoAccept ifTrue: [ self acceptContents ] ifFalse: [ self hasUnacceptedEdits: true ].
	self rulers do: [ :r | r textChanged ].
	self updateChooser
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> textColor [
	^ self textArea textColor
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> textColor: aColor [ 
	self textArea textColor: aColor
]

{ #category : 'geometry' }
SpRubTextFieldMorph >> textFieldHeight [
	| vgap |
	vgap := self currentHScrollBarThickness isZero
		ifTrue: [  0 ]
		ifFalse: [ self currentHScrollBarThickness - 1 ].
	^ self textArea height + 1 + (self borderWidth * 2) + vgap
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> textFont [
	"We should clean"
	
	^ self textArea font
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> textFont: aFont [
	self textArea font: aFont
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> textMorph [
	^ self textArea
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> textSegmentIconsRuler [
	^ self rulerNamed: #textSegmentIcons
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> themeChanged [
	
	self color: self defaultColor.
	
	super themeChanged.
]

{ #category : 'private' }
SpRubTextFieldMorph >> unplug [
	self textArea ifNotNil: [ self textArea announcer unsubscribe: self ].
	self scrollPane
		ifNotNil: [ :scrollpane | 
			scrollpane announcer unsubscribe: self.
			scrollpane unplug ].
	super unplug
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> updateChooser [
	entryCompletion
		ifNotNil: [  self openChooser ] 
]

{ #category : 'acessing text' }
SpRubTextFieldMorph >> updateTextWith: stringOrText [
	"Accept new text contents with line breaks only as in the text.
	Fit my width and height to the result."

	self scrollPane updateTextWith: stringOrText.	
	"self setSelection: self getSelection."
	self resetState
]

{ #category : 'accessing scrollbars' }
SpRubTextFieldMorph >> vScrollbarShowNever [
	self scrollPane vScrollbarShowNever
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> verticalRulers [
	^self rulers select: [ :r | r isVertical ]
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> wantsFrameAdornments: aBoolean [
	aBoolean ifTrue: [ self withAdornment  ] ifFalse: [ self withoutAdornment ]
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenCancelEditRequested: anAnnouncement [
	self announcer announce: anAnnouncement.
	self cancel

]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenCancelEditRequestedInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self cancel

]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenConfigurationChanged: anAnnouncement [
	anAnnouncement configurationBlock value: self

]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenConfigurationChangedFromModel: anAnnouncement [
	self announcer announce: anAnnouncement

]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenEditsStateChangedInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self basicHasUnacceptedEdits: self model hasUnacceptedEdits.
	self changed

]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenGotForcus: anAnnouncement [
	self announcer announce: anAnnouncement.
	self changed
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenKeystrokeInTextArea: anAnnouncement [
	self announcer announce: (anAnnouncement copy morph: self).
	entryCompletion ifNotNil: [entryCompletion keystroke: anAnnouncement event from: self]
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenLostFocus: anAnnouncement [
	self announcer announce: anAnnouncement.
	self changed
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenPrimarySelectionUpdatedInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self setTextAreaSelection: self getSelectionFromModel.


]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenReturnEntered: anAnnouncement [
	self acceptOnCR
		ifTrue: [
			anAnnouncement accepted: true ].
	self changed
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenReturnEnteredInTextArea: anAnnouncement [ 
	anAnnouncement morph: self.
	self announcer announce: anAnnouncement
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenTextAcceptRequest: anAnnouncement [
	self announcer announce: anAnnouncement.
	self acceptContents
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenTextAcceptedInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self acceptContents

]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenTextChangedInTextArea: anAnnouncement [ 
	self announcer announce: anAnnouncement
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenTextSetInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self scrollPane setTextWith: self getTextFromModel
]

{ #category : 'event handling' }
SpRubTextFieldMorph >> whenTextUpdatedInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self updateTextWith: self getTextFromModel

]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withAdornment [
	self withRulerNamed: #adornment
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withAnnotation [
	self withRulerNamed: #annotation
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withCodeSizeFeedback [
	self withRulerNamed: #codeSizeFeedback
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withColumns [
	self withRulerNamed: #column
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withCommentAnnotation [
	self withRulerNamed: #commentAnnotation
]

{ #category : 'accessing decorators' }
SpRubTextFieldMorph >> withDecoratorNamed: aSymbol [
	self textArea withDecoratorNamed: aSymbol
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> withDropListButton [
	self withRulerNamed: #dropListButton
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> withFocusBorder [
	self scrollPane drawFocusBorder: true
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withGhostText: aText [
	aText ifNil: [ ^ self withoutRulerNamed: #ghostText ].
	self withRulerNamed: #ghostText.
	self ghostTextRuler updateTextWith: aText asText.
	self ghostTextRuler comeToFront
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withLineNumbers [
	self withRulerNamed: #lineNumbers
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> withRuler: aRuler [
	(self hasRulerNamed: aRuler key)
		ifTrue: [ ^ self ].
	rulers add: aRuler.
	aRuler level >= 0 ifTrue: [self addMorphBack: aRuler].
	"Extra areas must be in the front "
	self extraAreas do: [ :r | self addMorphFront: r ].
	self manageLayout.
	" Finnally, the scrollPane must be in the front of all because text must be drawn last "
	self addMorphFront: self scrollPane.
	aRuler level < 0 ifTrue: [ self addMorphFront: aRuler ]
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> withRulerNamed: aKey [
	"returns the ruler associated with the aKey. It can be in the receiver or in the extra hierarchy.
	aKey is a symbol i.e., #lineNumbers"
	(self hasRulerNamed: aKey)
		ifTrue: [ ^ self ].
	(self classOfRulerNamed: aKey)
		ifNotNil: [ :cls | self withRuler: cls new ]
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> withRulersNamed: aCollection [
	"returns a collection of rulers as described by aCollection of keys. It can be in the receiver or in the extra hierarchy"
	aCollection do: [ :m | self withRulerNamed: m ]
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withSourceCodeAnnotation [
	self withRulerNamed: #SourceCodeAnnotation
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withTextSegmentIcons [
	self withRulerNamed: #textSegmentIcons

]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withoutAdornment [
	self withoutRulerNamed: #adornment
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withoutAnnotation [
	self withoutRulerNamed: #annotation
]

{ #category : 'accessing decorators' }
SpRubTextFieldMorph >> withoutAnyDecorator [
	self textArea withoutAnyDecorator
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withoutCodeSizeFeedback [
	self withoutRulerNamed: #codeSizeFeedback
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withoutColumns [
	self withoutRulerNamed: #column
]

{ #category : 'accessing decorators' }
SpRubTextFieldMorph >> withoutDecoratorNamed: aSymbol [
	self textArea withoutDecoratorNamed: aSymbol
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> withoutDropListButton [
	self withoutRulerNamed: #dropListButton
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> withoutFocusBorder [
	self scrollPane drawFocusBorder: false
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withoutGhostText [
	self withoutRulerNamed: #ghostText.

]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withoutLineNumbers [
	self withoutRulerNamed: #lineNumbers
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> withoutRuler: aRuler [
	(self hasRuler: aRuler)
		ifFalse: [ ^ self ].
	rulers remove: aRuler.
	self removeMorph: aRuler.
	self manageLayout.
	self changed
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> withoutRulerNamed: aKey [
	(self rulerNamed: aKey)
		ifNotNil: [ :m | self withoutRuler: m ].
	self changed
]

{ #category : 'rulers handling' }
SpRubTextFieldMorph >> withoutRulersNamed: aCollection [
	aCollection do: [ :m | self withoutRulerNamed: m ]
]

{ #category : 'accessing decorators' }
SpRubTextFieldMorph >> withoutSelectionBar [
	self textArea withoutSelectionBar
]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withoutTextField [
	self withoutRulerNamed: #textField.

]

{ #category : 'accessing rulers' }
SpRubTextFieldMorph >> withoutTextSegmentIcons [
	self withoutRulerNamed: #textSegmentIcons

]

{ #category : 'accessing' }
SpRubTextFieldMorph >> wrapFlag: aBoolean [
	self wrapped: aBoolean
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> wrapped [
	^ self scrollPane wrapped
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> wrapped: aBoolean [
	self scrollPane wrapped: aBoolean
]
