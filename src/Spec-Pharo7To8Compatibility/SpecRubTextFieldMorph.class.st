Class {
	#name : #SpecRubTextFieldMorph,
	#superclass : #RubScrolledTextMorph,
	#instVars : [
		'hasValidText',
		'acceptOnCR',
		'entryCompletion',
		'maxLength',
		'askBeforeDiscardingEdits',
		'getBackgroundColorSelector'
	],
	#category : #'Spec-Pharo7To8Compatibility'
}

{ #category : #'instance creation' }
SpecRubTextFieldMorph class >> on: aModel [ 
	^ self new on: aModel
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> accept [
	self acceptContents.
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> acceptContents [
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

{ #category : #accessing }
SpecRubTextFieldMorph >> acceptOnCR [
	^ acceptOnCR 
]

{ #category : #accessing }
SpecRubTextFieldMorph >> acceptOnCR: aBoolean [
	acceptOnCR := aBoolean
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> acceptTextInModel [
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

{ #category : #'accessing segments' }
SpecRubTextFieldMorph >> addSegment: aRubTextSegmentMorph [
	^ self textArea addSegment: aRubTextSegmentMorph

]

{ #category : #drawing }
SpecRubTextFieldMorph >> adornmentColor [
	"color to Indicate edit status for the given morph."

	self hasValidText
		ifFalse: [ ^ Color red ].
	self hasEditingConflicts
		ifTrue: [ ^ Color red ].
	self hasUnacceptedEdits
		ifTrue: [ ^ Color orange ].
	^ Color transparent
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> adornmentRuler [
	^ self rulerNamed: #adornment
]

{ #category : #'accessing menu' }
SpecRubTextFieldMorph >> allowMenu [
	self menuAllowed: true
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> alwaysAccept [
	^ alwaysAccept ifNil: [ alwaysAccept := false]
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> alwaysAccept: aBoolean [
	"Set the always accept flag."
	"This flag is used when there are unsaved changes in my text field and an exterior actor tries to modify me"
	"If the flag is true, I will accept to change even if I have pending modification instead of poping up the Accept/Discard/Cancel window"


	alwaysAccept := aBoolean
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> annotationRuler [
	^ self rulerNamed: #annotation
]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> appendText: stringOrText [
	"Accept new text contents with line breaks only as in the text.
	Fit my width and height to the result."

	self scrollPane appendText: stringOrText.	
	self resetState
]

{ #category : #accessing }
SpecRubTextFieldMorph >> askBeforeDiscardingEdits: aBoolean [
	"Set the flag that determines whether the user should be asked before discarding unaccepted edits."

	askBeforeDiscardingEdits := aBoolean
]

{ #category : #accessing }
SpecRubTextFieldMorph >> autoAccept [
	"Answer whether the editor accepts its contents on each change."

	^autoAccept ifNil: [autoAccept := false]
]

{ #category : #accessing }
SpecRubTextFieldMorph >> autoAccept: aBoolean [
	"Whether I should accept my contents on each change."
	autoAccept := aBoolean.
	aBoolean
		ifTrue: [ self withoutAdornment]
		ifFalse: [ self withAdornment ]
]

{ #category : #accessing }
SpecRubTextFieldMorph >> backgroundColor [
	^self scrollPane color
]

{ #category : #accessing }
SpecRubTextFieldMorph >> backgroundColor: aColor [
	self scrollPane color: aColor
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> basicHasUnacceptedEdits: aBoolean [
	self autoAccept
		ifTrue: [ ^ self ].
	aBoolean = hasUnacceptedEdits 
		ifFalse: [ hasUnacceptedEdits := aBoolean.
			self changed].
	aBoolean 
		ifFalse: [hasEditingConflicts := false]
]

{ #category : #encryption }
SpecRubTextFieldMorph >> beDecrypted [

	self textMorph font: TextStyle defaultFont.
]

{ #category : #accessing }
SpecRubTextFieldMorph >> beEditable [
	self textArea beEditable 
]

{ #category : #encryption }
SpecRubTextFieldMorph >> beEncrypted [

	self textMorph font: (StrikeFont passwordFontSize: self theme textFont pointSize).
]

{ #category : #initialization }
SpecRubTextFieldMorph >> beForPlainText [
	self textArea beForPlainText
]

{ #category : #initialization }
SpecRubTextFieldMorph >> beForSmalltalkCode [
	self textArea beForSmalltalkCode.
	self withTextSegmentIcons.
	self textArea font: StandardFonts codeFont
]

{ #category : #initialization }
SpecRubTextFieldMorph >> beForSmalltalkCodeInClass: aClass [
	self textArea beForSmalltalkCodeInClass: aClass.
	self withTextSegmentIcons.
	self textArea font: StandardFonts codeFont
]

{ #category : #initialization }
SpecRubTextFieldMorph >> beForSmalltalkCodeWithDefaultFont [
	self textArea beForSmalltalkCodeWithDefaultFont.
	self withTextSegmentIcons
]

{ #category : #initialization }
SpecRubTextFieldMorph >> beForSmalltalkComment [
	self textArea beForSmalltalkComment
]

{ #category : #accessing }
SpecRubTextFieldMorph >> beForSmalltalkScripting [
    self textArea beForSmalltalkScripting.
    self textArea font: StandardFonts codeFont

]

{ #category : #accessing }
SpecRubTextFieldMorph >> beForSmalltalkScriptingWithDefaultFont [
    self textArea beForSmalltalkScriptingWithDefaultFont

]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> beNotWrapped [
	self scrollPane beNotWrapped 
]

{ #category : #accessing }
SpecRubTextFieldMorph >> beReadOnly [
	self textArea beReadOnly 
]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> beWrapped [
	self scrollPane beWrapped
]

{ #category : #accessing }
SpecRubTextFieldMorph >> borderStyleToUse [
	"Answer the borderStyle that should be used for the receiver."
	
	^self enabled
		ifTrue: [self theme rubScrolledTextMorphThemer normalBorderStyleFor: self]
		ifFalse: [self theme rubScrolledTextMorphThemer disabledBorderStyleFor: self]
]

{ #category : #'accessing scrollbars' }
SpecRubTextFieldMorph >> borderWidth: anInteger [
	super borderWidth: anInteger.
	self extent: self extent.
	self manageLayout 
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> canDiscardEdits [
	^ (self hasUnacceptedEdits and: [askBeforeDiscardingEdits]) not

]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> cancel [

	self updateTextWith: self getTextFromModel.
	self setSelection: self getSelectionFromModel
]

{ #category : #testing }
SpecRubTextFieldMorph >> chooserHasFocus [
	^ self chooserIsOpened and: [entryCompletion chooser hasKeyboardFocus]
]

{ #category : #testing }
SpecRubTextFieldMorph >> chooserIsOpened [
	^ entryCompletion notNil and: [entryCompletion chooser notNil]
]

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> classOfRulerNamed: aKey [
	^ RubScrolledTextExtra classOfRulerNamed: aKey
]

{ #category : #accessing }
SpecRubTextFieldMorph >> classOrMetaClass: aBehavior [
	self textArea classOrMetaClass: aBehavior
]

{ #category : #accessing }
SpecRubTextFieldMorph >> closeChooser [	
	entryCompletion
		ifNotNil: [entryCompletion closeChooser]
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> columnRuler [
	^ self rulerNamed: #column
]

{ #category : #configure }
SpecRubTextFieldMorph >> configureGhostText: aTextArea [
	aTextArea width: self scrollBounds width.
	aTextArea center: self scrollBounds center.
	self hasKeyboardFocus
		ifTrue: [ 
			aTextArea left: self left]
]

{ #category : #'interactive error protocol' }
SpecRubTextFieldMorph >> correctFrom: start to: stop with: aString [
	self textArea correctFrom: start to: stop with: aString
]

{ #category : #'accessing scrollbars' }
SpecRubTextFieldMorph >> currentHScrollBarThickness [
	^self scrollPane currentHScrollBarThickness
]

{ #category : #'accessing text area' }
SpecRubTextFieldMorph >> cursor [
	"polymorphism with text area"
	^ self textArea cursor
]

{ #category : #defaults }
SpecRubTextFieldMorph >> defaultBackgroundColor [ 
	^ self theme backgroundColor
]

{ #category : #defaults }
SpecRubTextFieldMorph >> defaultBorderWidth [
	^ 0
]

{ #category : #defaults }
SpecRubTextFieldMorph >> defaultColor [
	^ self defaultBackgroundColor 
]

{ #category : #defaults }
SpecRubTextFieldMorph >> defaultGhostTextMorph [
	| gt |
	gt := RubEditingArea new.
	gt withoutAnyDecorator.
	gt backgroundColor: Color transparent.
	gt beReadOnly.
	gt beWrapped.
	^ gt beNotWrapped 
]

{ #category : #initialization }
SpecRubTextFieldMorph >> defaultScrollTarget [
	| textArea |
	textArea := self textAreaClass new.
	textArea backgroundColor: Color lightGray veryMuchLighter.
	^ textArea
]

{ #category : #protocol }
SpecRubTextFieldMorph >> disable [
	self beReadOnly 
]

{ #category : #accessing }
SpecRubTextFieldMorph >> drawFocusBorder [
	^ self scrollPane drawFocusBorder
]

{ #category : #accessing }
SpecRubTextFieldMorph >> drawFocusBorder: aBoolean [
	self scrollPane drawFocusBorder: aBoolean
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> drawHighlightsOn: aCanvas [
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

{ #category : #drawing }
SpecRubTextFieldMorph >> drawOn: aCanvas [
	super drawOn: aCanvas.
	self drawHighlightsOn: aCanvas 
]

{ #category : #drawing }
SpecRubTextFieldMorph >> drawOnAthensCanvas: anAthensCanvas [
	"Indicate unaccepted edits, conflicts etc."

	super drawOnAthensCanvas: anAthensCanvas. 
	self drawHighlightsOn: anAthensCanvas asCanvasWrapper
]

{ #category : #drawing }
SpecRubTextFieldMorph >> drawSubmorphsOn: aCanvas [
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

{ #category : #drawing }
SpecRubTextFieldMorph >> drawSubmorphsOnAthensCanvas: anAthensCanvas [
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

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> editPrimarySelectionSeparately [
	self textArea editPrimarySelectionSeparately
]

{ #category : #accessing }
SpecRubTextFieldMorph >> editingMode [
	^  self textArea editingMode
]

{ #category : #accessing }
SpecRubTextFieldMorph >> editingMode: anEditingMode [
	self textArea editingMode: anEditingMode.

]

{ #category : #accessing }
SpecRubTextFieldMorph >> editingModeClass [
	^ self textArea editingMode class
]

{ #category : #'mock for spec' }
SpecRubTextFieldMorph >> enabled: aBoolean [
	enabled = aBoolean ifTrue: [^self].
	enabled := aBoolean.
	self textArea readOnly: aBoolean not.
	self changed
]

{ #category : #accessing }
SpecRubTextFieldMorph >> encrypted: aBoolean [

	aBoolean
		ifTrue: [ self beEncrypted ]
		ifFalse: [ self beDecrypted ]
]

{ #category : #accessing }
SpecRubTextFieldMorph >> entryCompletion [ 
	^ entryCompletion 
]

{ #category : #accessing }
SpecRubTextFieldMorph >> entryCompletion: anEntryCompletion [
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

{ #category : #geometry }
SpecRubTextFieldMorph >> extent: aPoint [
	super extent: aPoint x @ self textFieldHeight.
	self manageLayout
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> extraAreas [
	^ self rulers select: [ :r | r isOver ]

]

{ #category : #focus }
SpecRubTextFieldMorph >> focusChanged [
	(self hasFocus or: [self chooserHasFocus])
		ifFalse: [self closeChooser].
	super focusChanged

]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> font [
	^ self textArea font
]

{ #category : #'accessing text area' }
SpecRubTextFieldMorph >> font: aFont [
	"polymorphism with text area"
	self textFont: aFont
]

{ #category : #'accessing menu' }
SpecRubTextFieldMorph >> forbidMenu [
	self menuAllowed: false
]

{ #category : #formatting }
SpecRubTextFieldMorph >> formatSourceCode [
	self textArea formatMethodCode
]

{ #category : #accessing }
SpecRubTextFieldMorph >> getBackgroundColorFromModel [
	"Retrieve the color from the model"

	self getBackgroundColorSelector ifNil: [^ self ].
	^ self model perform: self getBackgroundColorSelector withEnoughArguments: {self}.
]

{ #category : #accessing }
SpecRubTextFieldMorph >> getBackgroundColorSelector [ 
	^ getBackgroundColorSelector 
]

{ #category : #accessing }
SpecRubTextFieldMorph >> getBackgroundColorSelector: aSelector [
	getBackgroundColorSelector := aSelector
]

{ #category : #'accessing menu' }
SpecRubTextFieldMorph >> getMenuPolicy: aGetMenuPolicy [
	self textArea getMenuPolicy: aGetMenuPolicy
]

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> getSelectionFromModel [
	"Answer the model's selection interval."

	^ self getSelectionSelector ifNotNil: [ :s | self model perform: s withEnoughArguments: {self} ]
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> getSelectionSelector [
	^ getSelectionSelector
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> getSelectionSelector: aSelector [
	getSelectionSelector := aSelector.

]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> getText [
	"Retrieve the current view text, possibly not accepted"

	^ self textArea text
]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> getTextFromModel [
	"Retrieve the current model text"

	| newText |
	self getTextSelector ifNil: [^Text new].
	newText := (self model perform: self getTextSelector withEnoughArguments: {self}).
	newText ifNil: [^Text new].
	^newText copy asText
]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> getTextFromView [
	"Retrieve the current view text, possibly not accepted"

	^ self textArea text
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> getTextSelector [
	^ getTextSelector ifNil: [  getTextSelector := #getText ]
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> getTextSelector: aSymbol [ 
	getTextSelector  := aSymbol
]

{ #category : #accessing }
SpecRubTextFieldMorph >> ghostText [
	^ (self rulerNamed: #ghostText) ghostText text
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> ghostText: aText [
	self withGhostText: aText
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> ghostTextRuler [
	^ self rulerNamed: #ghostText
]

{ #category : #'accessing scrollbars' }
SpecRubTextFieldMorph >> hScrollbarShowAlways [
	self scrollPane hScrollbarShowAlways.
	self extent: self extent.
	self manageLayout 
]

{ #category : #'accessing scrollbars' }
SpecRubTextFieldMorph >> hScrollbarShowNever [
	self scrollPane hScrollbarShowNever
]

{ #category : #'accessing scrollbars' }
SpecRubTextFieldMorph >> hScrollbarShowWhenNeeded [
	self scrollPane hScrollbarShowWhenNeeded
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> handleMouseDown: event [
	^ super handleMouseDown: event
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> handlesKeyboard: evt [
	"Yes for page up/down."
	
	^true
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> handlesMouseDown: event [
	^ self scrollBounds containsPoint: event cursorPoint
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> handlesMouseWheel: evt [
	"Do I want to receive mouseWheel events?" 

	^ true
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> hasEditingConflicts [
	^ hasEditingConflicts
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> hasEditingConflicts: aBoolean [
	hasEditingConflicts := aBoolean
]

{ #category : #accessing }
SpecRubTextFieldMorph >> hasKeyboardFocus [
	^ (self scrollPane ifNil: [ ^false ]) hasKeyboardFocus
]

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> hasRuler: aRuler [
	^ self rulers includes: aRuler
	
]

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> hasRulerNamed: aKey [
	^ self rulers anySatisfy: [ :r | r key = aKey ]
	
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> hasUnacceptedEdits [
	^ hasUnacceptedEdits
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> hasUnacceptedEdits: aBoolean [
	"Set the hasUnacceptedEdits flag to the given value. "
	
	(self model respondsTo: #hasUnacceptedEdits:)
		ifTrue: [ self model hasUnacceptedEdits: aBoolean ]
		ifFalse: [ self basicHasUnacceptedEdits: aBoolean ]
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> hasValidText [
	^ hasValidText
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> hasValidText: aBoolean [
	hasValidText := aBoolean
]

{ #category : #accessing }
SpecRubTextFieldMorph >> highlights [
	^ highlights
]

{ #category : #accessing }
SpecRubTextFieldMorph >> highlights: anObject [
	highlights := anObject
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> horizontalRulers [
	^self rulers select: [ :r | r isHorizontal ]
]

{ #category : #initialization }
SpecRubTextFieldMorph >> initialize [
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

{ #category : #testing }
SpecRubTextFieldMorph >> isReadOnly [
	^ self textArea isReadOnly 
]

{ #category : #classification }
SpecRubTextFieldMorph >> isRenderer [
	^ true
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> keyStroke: event [
	self scrollPane
		ifNotNil: [ :scrollpane | scrollpane keyStroke: (event transformedBy: (scrollpane transformFrom: self)) ]
]

{ #category : #focus }
SpecRubTextFieldMorph >> keyboardFocusChange: aBoolean [
	self closeChooser.
	super keyboardFocusChange: aBoolean.

]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> lineNumbersRuler [
	^ self rulerNamed: #lineNumbers
]

{ #category : #layout }
SpecRubTextFieldMorph >> manageLayout [
	| ret |
	self textArea ifNil: [ ^self ].
	ret := self manageLayoutInBounds: self innerBounds.
	self layoutChanged.
	^ret
]

{ #category : #defaults }
SpecRubTextFieldMorph >> manageLayoutInBounds: aRectangle [
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

{ #category : #'accessing text area' }
SpecRubTextFieldMorph >> margins: aMargin [
	"polymorphism with text area"
	self textArea margins: aMargin
]

{ #category : #accessing }
SpecRubTextFieldMorph >> maxLength [
	
	"Returns the max length of this text field.
	0 meaning unlimited"
	^ maxLength
]

{ #category : #accessing }
SpecRubTextFieldMorph >> maxLength: anInteger [
	"Sets the max length of the text field.
	0 means unlimited"
	maxLength := anInteger.
	maxLength = 0 ifTrue: [ ^ self ].
	
	"If the contents of this textfield exceed the max length, contents are truncated"
	self getText size > maxLength
		ifTrue: [ self setText: (self getText first: maxLength) ]
]

{ #category : #'accessing menu' }
SpecRubTextFieldMorph >> menuAllowed: aBoolean [
	self textArea menuAllowed: aBoolean
]

{ #category : #accessing }
SpecRubTextFieldMorph >> menuProvider: anObject selector: aSelector [
	self textArea
		getMenuPolicy:
			(RubPluggableGetMenuPolicy new
				getMenuSelector: aSelector;
				menuProvider: anObject;
				yourself)
]

{ #category : #accessing }
SpecRubTextFieldMorph >> model [ 
	^self textArea model
]

{ #category : #accessing }
SpecRubTextFieldMorph >> model: aModel [
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

{ #category : #'event handling' }
SpecRubTextFieldMorph >> mouseDown: event [
	"If pane is not empty, pass the event to the last submorph,
	assuming it is the most appropriate recipient (!)"

	(self innerBounds containsPoint: event cursorPoint)
		ifTrue: [ 
			self scrollPane mouseDown: event.
			self eventHandler ifNotNil: [ self eventHandler mouseDown: event fromMorph: self ] ]
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> mouseWheel: event [ 
	"Handle a mouseWheel event."
	
	(self scrollPane scrollTarget handlesMouseWheel: event)
		ifTrue: [^self scrollTarget mouseWheel: event]. "pass on"
]

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> moveCursorToIndex: anIndex [ 
	self selectFrom: anIndex to: anIndex - 1
]

{ #category : #initialization }
SpecRubTextFieldMorph >> newScrollPane [
	| sp |
	sp := RubTextScrollPane new.
	sp scrollTarget: self defaultScrollTarget.
	^ sp
]

{ #category : #'submorphs-accessing' }
SpecRubTextFieldMorph >> noteNewOwner: aMorph [ 
	super noteNewOwner: aMorph.
	self manageLayout 
]

{ #category : #accessing }
SpecRubTextFieldMorph >> notificationStrategy: aStrategy [
	self textArea notificationStrategy: aStrategy
]

{ #category : #'interactive error protocol' }
SpecRubTextFieldMorph >> notify: message at: location in: code [
	^ self textArea notify: message at: location in: code
]

{ #category : #accessing }
SpecRubTextFieldMorph >> offset [
	^ self scrollPane offset
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> on: aModel [ 
	self model: aModel.

]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> on: aModel text: aGetTextSelector accept: aSetTextSelector readSelection: aReadSelectionSelector menu: aGetMenuSelector [
	self getTextSelector: aGetTextSelector.
	self setTextSelector: aSetTextSelector.
	self getSelectionSelector: aReadSelectionSelector.
	aGetMenuSelector
		ifNil: [ self textArea forbidMenu ]
		ifNotNil: [ self menuProvider: aModel selector: aGetMenuSelector ].
	self on: aModel
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> on: anObject text: getTextSel accept: setTextSel readSelection: getSelectionSel menu: getMenuSel setSelection: setSelectionSel [
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

{ #category : #accessing }
SpecRubTextFieldMorph >> openChooser [	
	entryCompletion
		ifNotNil: [
			entryCompletion openChooserWith: self textArea text string from: self]
]

{ #category : #initialization }
SpecRubTextFieldMorph >> outOfWorld: aWorld [
	self closeChooser.
	super outOfWorld: aWorld
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> overRulers [
	^self rulers select: [ :r | r isOver ]
]

{ #category : #accessing }
SpecRubTextFieldMorph >> paragraph [
	^ self scrollPane paragraph 
]

{ #category : #geometry }
SpecRubTextFieldMorph >> position: aPoint [
	super position: aPoint.
	self manageLayout

	
]

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> removeAllRulers [
	[ self rulers notEmpty ] whileTrue: [ self withoutRuler: self rulers first ]
]

{ #category : #private }
SpecRubTextFieldMorph >> resetState [
	hasValidText := true.
		hasEditingConflicts := false.
	hasUnacceptedEdits := false.
	self changed
]

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> rulerNamed: aKey [
	^self rulers detect: [ :r | r key = aKey ] ifNone: [  ]
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> rulers [
	^ rulers 
]

{ #category : #geometry }
SpecRubTextFieldMorph >> scrollBounds [
	^ self scrollPane scrollBounds
]

{ #category : #accessing }
SpecRubTextFieldMorph >> scrollPane [
	^ scrollPane
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> scrollToBeginningOfLine [
	self scrollPane scrollToBeginningOfLine
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> scrollToBeginningOfText [
	self scrollPane scrollToBeginningOfText
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> scrollToEndOfLine [
	self scrollPane scrollToEndOfLine
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> scrollToEndOfText [
	self scrollPane scrollToEndOfText
]

{ #category : #'accessing scrollbars' }
SpecRubTextFieldMorph >> scrollbarsShowNever [
	self hScrollbarShowNever.
	self vScrollbarShowNever
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> scrollerExtentChanged [
	self manageLayout

]

{ #category : #'accessing scrollbars' }
SpecRubTextFieldMorph >> scrollerOffsetChanged [
	self rulers do: [:r | r scrollerOffsetChanged]
]

{ #category : #'accessing segments' }
SpecRubTextFieldMorph >> segments [
	^ self textArea segments

]

{ #category : #'accessing segments' }
SpecRubTextFieldMorph >> segmentsAtLine: aLineNumber [
	^ self textArea  segmentsAtLine: aLineNumber

]

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> selectAll [
	self selectFrom: 1 to: self text size 
]

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> selectFrom: firstIndex to: lastIndex [
	self selectionInterval: (firstIndex to: lastIndex)

]

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> selectionChanged [
	self rulers do: [ :r | r selectionChanged ].
	self setModelSelection: self selectionInterval

]

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> selectionInterval [
	^ self textArea selectionInterval
]

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> selectionInterval: anInterval [
	self setSelection: anInterval
]

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> setModelSelection: aSelectionInterval [
	"try to set the selection in the model"
	setSelectionSelector
		ifNotNil: [ self model perform: setSelectionSelector with: aSelectionInterval]
]

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> setSelection: aSelectionInterval [
	aSelectionInterval ifNil: [ ^ self ].
	self setTextAreaSelection: aSelectionInterval.
	self selectionChanged 
]

{ #category : #accessing }
SpecRubTextFieldMorph >> setSelectionSelector: aSelector [
	setSelectionSelector := aSelector
]

{ #category : #'mock for spec' }
SpecRubTextFieldMorph >> setText: aText [
	self updateTextWith: aText
]

{ #category : #'accessing-selection' }
SpecRubTextFieldMorph >> setTextAreaSelection: aSelectionInterval [
	aSelectionInterval ifNil: [ ^ self ].
	self textArea selectFrom: aSelectionInterval first to: aSelectionInterval last.
	self scrollPane scrollSelectionIntoView
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> setTextSelector [
	^ setTextSelector ifNil: [  setTextSelector := #setText:from:]
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> setTextSelector: aSymbol [ 
	setTextSelector  := aSymbol
]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> setTextWith: stringOrText [
	"Accept new text contents with line breaks only as in the text.
	Fit my width and height to the result."
	self scrollPane setTextWith: stringOrText.
	self setSelection: self getSelectionFromModel.
	self resetState
]

{ #category : #private }
SpecRubTextFieldMorph >> shoutStyler [
	^ self textArea shoutStyler
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> sideRulers [
	^self rulers select: [ :r | r isSideRuler ]
]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> tabWidth [
	^ self textArea tabWidth
]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> tabWidth: anInteger [
	self textArea tabWidth: anInteger 
]

{ #category : #'model protocol' }
SpecRubTextFieldMorph >> takeKeyboardFocus [
	self textArea takeKeyboardFocus
]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> text [
	^ self textArea text
]

{ #category : #accessing }
SpecRubTextFieldMorph >> textArea [
	^ self scrollPane ifNotNil: [:sp | sp textArea]
]

{ #category : #initialization }
SpecRubTextFieldMorph >> textAreaClass [
	^ RubTextFieldArea
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> textAreaExtentChanged [
	self manageLayout

]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> textChanged [
	self manageLayout.
	self autoAccept ifTrue: [ self acceptContents ] ifFalse: [ self hasUnacceptedEdits: true ].
	self rulers do: [ :r | r textChanged ].
	self updateChooser
]

{ #category : #accessing }
SpecRubTextFieldMorph >> textColor [
	^ self textArea textColor
]

{ #category : #accessing }
SpecRubTextFieldMorph >> textColor: aColor [ 
	self textArea textColor: aColor
]

{ #category : #geometry }
SpecRubTextFieldMorph >> textFieldHeight [
	| vgap |
	vgap := self currentHScrollBarThickness isZero
		ifTrue: [  0 ]
		ifFalse: [ self currentHScrollBarThickness - 1 ].
	^ self textArea height + 1 + (self borderWidth * 2) + vgap
]

{ #category : #accessing }
SpecRubTextFieldMorph >> textFont [
	"We should clean"
	
	^ self textArea font
]

{ #category : #accessing }
SpecRubTextFieldMorph >> textFont: aFont [
	self textArea font: aFont
]

{ #category : #accessing }
SpecRubTextFieldMorph >> textMorph [
	^ self textArea
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> textSegmentIconsRuler [
	^ self rulerNamed: #textSegmentIcons
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> themeChanged [
	
	self color: self defaultColor.
	
	super themeChanged.
]

{ #category : #private }
SpecRubTextFieldMorph >> unplug [
	self textArea ifNotNil: [ self textArea announcer unsubscribe: self ].
	self scrollPane
		ifNotNil: [ :scrollpane | 
			scrollpane announcer unsubscribe: self.
			scrollpane unplug ].
	super unplug
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> updateChooser [
	entryCompletion
		ifNotNil: [  self openChooser ] 
]

{ #category : #'acessing text' }
SpecRubTextFieldMorph >> updateTextWith: stringOrText [
	"Accept new text contents with line breaks only as in the text.
	Fit my width and height to the result."

	self scrollPane updateTextWith: stringOrText.	
	"self setSelection: self getSelection."
	self resetState
]

{ #category : #'accessing scrollbars' }
SpecRubTextFieldMorph >> vScrollbarShowNever [
	self scrollPane vScrollbarShowNever
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> verticalRulers [
	^self rulers select: [ :r | r isVertical ]
]

{ #category : #accessing }
SpecRubTextFieldMorph >> wantsFrameAdornments: aBoolean [
	aBoolean ifTrue: [ self withAdornment  ] ifFalse: [ self withoutAdornment ]
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenCancelEditRequested: anAnnouncement [
	self announcer announce: anAnnouncement.
	self cancel

]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenCancelEditRequestedInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self cancel

]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenConfigurationChanged: anAnnouncement [
	anAnnouncement configurationBlock value: self

]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenConfigurationChangedFromModel: anAnnouncement [
	self announcer announce: anAnnouncement

]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenEditsStateChangedInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self basicHasUnacceptedEdits: self model hasUnacceptedEdits.
	self changed

]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenGotForcus: anAnnouncement [
	self announcer announce: anAnnouncement.
	self changed
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenKeystrokeInTextArea: anAnnouncement [
	self announcer announce: (anAnnouncement copy morph: self).
	entryCompletion ifNotNil: [entryCompletion keystroke: anAnnouncement event from: self]
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenLostFocus: anAnnouncement [
	self announcer announce: anAnnouncement.
	self changed
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenPrimarySelectionUpdatedInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self setTextAreaSelection: self getSelectionFromModel.


]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenReturnEntered: anAnnouncement [
	self acceptOnCR
		ifTrue: [
			anAnnouncement accepted: true ].
	self changed
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenReturnEnteredInTextArea: anAnnouncement [ 
	anAnnouncement morph: self.
	self announcer announce: anAnnouncement
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenTextAcceptRequest: anAnnouncement [
	self announcer announce: anAnnouncement.
	self acceptContents
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenTextAcceptedInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self acceptContents

]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenTextChangedInTextArea: anAnnouncement [ 
	self announcer announce: anAnnouncement
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenTextSetInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self scrollPane setTextWith: self getTextFromModel
]

{ #category : #'event handling' }
SpecRubTextFieldMorph >> whenTextUpdatedInModel: anAnnouncement [
	self announcer announce: anAnnouncement.
	self updateTextWith: self getTextFromModel

]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withAdornment [
	self withRulerNamed: #adornment
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withAnnotation [
	self withRulerNamed: #annotation
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withCodeSizeFeedback [
	self withRulerNamed: #codeSizeFeedback
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withColumns [
	self withRulerNamed: #column
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withCommentAnnotation [
	self withRulerNamed: #commentAnnotation
]

{ #category : #'accessing decorators' }
SpecRubTextFieldMorph >> withDecoratorNamed: aSymbol [
	self textArea withDecoratorNamed: aSymbol
]

{ #category : #initialization }
SpecRubTextFieldMorph >> withDropListButton [
	self withRulerNamed: #dropListButton
]

{ #category : #accessing }
SpecRubTextFieldMorph >> withFocusBorder [
	self scrollPane drawFocusBorder: true
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withGhostText: aText [
	aText ifNil: [ ^ self withoutRulerNamed: #ghostText ].
	self withRulerNamed: #ghostText.
	self ghostTextRuler updateTextWith: aText asText.
	self ghostTextRuler comeToFront
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withLineNumbers [
	self withRulerNamed: #lineNumbers
]

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> withRuler: aRuler [
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

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> withRulerNamed: aKey [
	"returns the ruler associated with the aKey. It can be in the receiver or in the extra hierarchy.
	aKey is a symbol i.e., #lineNumbers"
	(self hasRulerNamed: aKey)
		ifTrue: [ ^ self ].
	(self classOfRulerNamed: aKey)
		ifNotNil: [ :cls | self withRuler: cls new ]
]

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> withRulersNamed: aCollection [
	"returns a collection of rulers as described by aCollection of keys. It can be in the receiver or in the extra hierarchy"
	aCollection do: [ :m | self withRulerNamed: m ]
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withSourceCodeAnnotation [
	self withRulerNamed: #SourceCodeAnnotation
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withTextSegmentIcons [
	self withRulerNamed: #textSegmentIcons

]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withoutAdornment [
	self withoutRulerNamed: #adornment
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withoutAnnotation [
	self withoutRulerNamed: #annotation
]

{ #category : #'accessing decorators' }
SpecRubTextFieldMorph >> withoutAnyDecorator [
	self textArea withoutAnyDecorator
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withoutCodeSizeFeedback [
	self withoutRulerNamed: #codeSizeFeedback
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withoutColumns [
	self withoutRulerNamed: #column
]

{ #category : #'accessing decorators' }
SpecRubTextFieldMorph >> withoutDecoratorNamed: aSymbol [
	self textArea withoutDecoratorNamed: aSymbol
]

{ #category : #initialization }
SpecRubTextFieldMorph >> withoutDropListButton [
	self withoutRulerNamed: #dropListButton
]

{ #category : #accessing }
SpecRubTextFieldMorph >> withoutFocusBorder [
	self scrollPane drawFocusBorder: false
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withoutGhostText [
	self withoutRulerNamed: #ghostText.

]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withoutLineNumbers [
	self withoutRulerNamed: #lineNumbers
]

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> withoutRuler: aRuler [
	(self hasRuler: aRuler)
		ifFalse: [ ^ self ].
	rulers remove: aRuler.
	self removeMorph: aRuler.
	self manageLayout.
	self changed
]

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> withoutRulerNamed: aKey [
	(self rulerNamed: aKey)
		ifNotNil: [ :m | self withoutRuler: m ].
	self changed
]

{ #category : #'rulers handling' }
SpecRubTextFieldMorph >> withoutRulersNamed: aCollection [
	aCollection do: [ :m | self withoutRulerNamed: m ]
]

{ #category : #'accessing decorators' }
SpecRubTextFieldMorph >> withoutSelectionBar [
	self textArea withoutSelectionBar
]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withoutTextField [
	self withoutRulerNamed: #textField.

]

{ #category : #'accessing rulers' }
SpecRubTextFieldMorph >> withoutTextSegmentIcons [
	self withoutRulerNamed: #textSegmentIcons

]

{ #category : #accessing }
SpecRubTextFieldMorph >> wrapFlag: aBoolean [
	self wrapped: aBoolean
]

{ #category : #accessing }
SpecRubTextFieldMorph >> wrapped [
	^ self scrollPane wrapped
]

{ #category : #accessing }
SpecRubTextFieldMorph >> wrapped: aBoolean [
	self scrollPane wrapped: aBoolean
]
