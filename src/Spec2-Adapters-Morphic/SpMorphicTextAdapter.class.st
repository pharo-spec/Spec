"
I am the adapter used to bridge a TextPresenter and a RubScrolledTextMorph for regular text
"
Class {
	#name : 'SpMorphicTextAdapter',
	#superclass : 'SpMorphicBaseTextAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'visiting' }
SpMorphicTextAdapter >> accept: aString notifying: aNotifyier [

	^ super 
		accept: (aString ifNotNil: [ aString asString ])
		notifying: aNotifyier
]

{ #category : 'widget API' }
SpMorphicTextAdapter >> addExtraActionsTo: actionGroup [
		
	"override to add extra actions between user defined and edition"
]

{ #category : 'initialization' }
SpMorphicTextAdapter >> addFocusRotationKeyBindings [
	"Text areas needs to be able to process tab. Cancel the binding."
]

{ #category : 'accessing' }
SpMorphicTextAdapter >> appendText: aString [

	self widget appendText: aString
]

{ #category : 'api' }
SpMorphicTextAdapter >> backendIncludesEditionMenu [

	^ false
]

{ #category : 'protocol - shortcuts' }
SpMorphicTextAdapter >> bindKeyCombination: aShortcut toAction: aBlock [

	self widgetDo: [ :w | 
		w textArea
			bindKeyCombination: aShortcut 
			toAction: aBlock ]
]

{ #category : 'factory' }
SpMorphicTextAdapter >> buildWidget [
	| newWidget |
	
	newWidget := (SpRubScrolledTextMorph on: self)
		getTextSelector: #getText;
		setTextSelector: #accept:notifying:;
		getSelectionSelector: #readSelection;
		menuProvider: self selector: #codePaneMenu:shifted:;
		setSelectionSelector: #setSelection:;
		ghostText: self placeholder;
		beWrapped;
		askBeforeDiscardingEdits: false;
		autoAccept: true;
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		setBalloonText: self help;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		registerScrollChanges: #scrollValueChanged:;
		hScrollbarShowWhenNeeded;
		yourself.

	self setEnabled: self presenter isEnabled to: newWidget.	
	self setEditable: self presenter isEditable to: newWidget.
	self setEditingModeFor: newWidget.

	self setText: self presenter text to: newWidget.
	self presenter selectionInterval 
		ifNotEmpty: [  :anInterval | self selectionInterval: anInterval on: newWidget ]
		ifEmpty: [
			self presenter text ifNotNil: [ :aString |
				self cursorPositionIndex: aString size + 1 to: newWidget.
			self selectionInterval: (aString size + 1 to: aString size) on: newWidget ]. ].
	
	self setWrapWord: self presenter isWrapWord to: newWidget.	
	self setUndoRedo: self presenter hasUndoRedoHistory to: newWidget. 
	self presenter whenSelectionChangedDo: [ :selectionInterval | 
		self selectionInterval: selectionInterval ].
	self presenter whenPlaceholderChangedDo: [ :text | 
		self setGhostText: text to: newWidget ].
	self presenter whenEditableChangedDo: [ :value | 
		self setEditable: value to: newWidget ].
	self presenter whenWrapWordChangedDo: [ :value | 
		self setWrapWord: value to: newWidget ].
	
	^ newWidget
]

{ #category : 'widget API' }
SpMorphicTextAdapter >> codePaneMenu: aMenu shifted: shifted [
	| menuPresenter actionGroup |
	
	actionGroup := SpActionGroup new beRoot.
	
	self presenter internalActions ifNotNil: [ :group |
		actionGroup add: group beRoot ].
	self addExtraActionsTo: actionGroup.
	self presenter actions ifNotNil: [ :group |
		actionGroup add: group beRoot ].
	self presenter hasEditionContextMenu ifTrue: [
		actionGroup add: self presenter editionCommandsGroup beRoot ].

	menuPresenter := self presenter newMenu.
	menuPresenter fillWith: actionGroup.

	"apply context menu if there is one"
	self presenter contextMenu ifNotNil: [ :aContextMenu | 
		self presenter actions ifNotNil: [ 
			Error signal: 'You are using contextMenu: and actions: at the same time. Both mechanisms are mutually exclusive.' ].
		menuPresenter := aContextMenu ].
	
	^ SpBindings
		  value: self model application adapterBindings
		  during: [ menuPresenter value build ]
]

{ #category : 'commands' }
SpMorphicTextAdapter >> copyText [

	self editor copySelection
]

{ #category : 'widget API' }
SpMorphicTextAdapter >> cursorPosition [

	^ self widgetDo: [ :w |
		w textArea selectionStart
			ifNotNil: [ :sel | self linePositionOf: sel ] ]
]

{ #category : 'widget API' }
SpMorphicTextAdapter >> cursorPositionIndex: index to: aWidget [

	aWidget textArea pointBlock: (aWidget textArea paragraph characterBlockForIndex: index)
]

{ #category : 'commands' }
SpMorphicTextAdapter >> cutText [

	self editor cut
]

{ #category : 'private' }
SpMorphicTextAdapter >> editor [

	^ widget textArea editor
]

{ #category : 'private' }
SpMorphicTextAdapter >> eventHandlerReceiver: aWidget [

	^ aWidget textArea
]

{ #category : 'commands' }
SpMorphicTextAdapter >> findNextText [

	self editor findAgain
]

{ #category : 'commands' }
SpMorphicTextAdapter >> findText [

	self editor find
]

{ #category : 'api' }
SpMorphicTextAdapter >> lineAtCursorPosition [

	^ self widgetDo: [ :w | 
		w textArea editor lineAtCursorPosition ]
]

{ #category : 'private' }
SpMorphicTextAdapter >> linePositionOf: sel [

	| textLine linePosition |
	textLine := sel textLine.
	linePosition := sel stringIndex - textLine first + 1.
	^ linePosition @ textLine lineNumber
]

{ #category : 'commands' }
SpMorphicTextAdapter >> pasteText [

	self editor paste
]

{ #category : 'styling' }
SpMorphicTextAdapter >> presenterStyles [
	"The presenters in the style"

	^ self presenter scrollBarStyles, self presenter styles 
]

{ #category : 'commands' }
SpMorphicTextAdapter >> selectAndPasteText [

	self editor pasteRecent
]

{ #category : 'private' }
SpMorphicTextAdapter >> setEditable: aBoolean to: aWidget [

	aWidget textArea readOnly: aBoolean not
]

{ #category : 'private' }
SpMorphicTextAdapter >> setGhostText: text to: aWidget [

	aWidget ghostText: text
]

{ #category : 'private' }
SpMorphicTextAdapter >> setText: text to: aWidget [

	updating ifTrue: [ ^ self ].

	aWidget textArea editingState clearUndoManager: nil.
	aWidget setText: text.
	self updateExtentPropagationOf: text on: aWidget
]

{ #category : 'factory' }
SpMorphicTextAdapter >> setUndoRedo: aBoolean to: newWidget [

	newWidget textArea editingState undoManager: (aBoolean 
		ifTrue: [ HistoryIterator new ]
		ifFalse: [ SpNullHistoryIterator new ])
]

{ #category : 'private' }
SpMorphicTextAdapter >> setWrapWord: aBoolean to: aWidget [

	aBoolean 
		ifTrue: [ aWidget beWrapped ]
		ifFalse: [ aWidget beNotWrapped ]
]

{ #category : 'accessing' }
SpMorphicTextAdapter >> text: aString [

	self setText: aString to: widget.
	self cursorPositionIndex: aString size + 1
]

{ #category : 'private' }
SpMorphicTextAdapter >> updateExtentPropagationOf: string on: aWidget [
	| stringMorph width height |

	(self presenter isPropagateNaturalWidth 
		or: [ self presenter isPropagateNaturalHeight ])
		ifFalse: [ ^ self ].

	"This is an incredible ugly hack because what should be the correct way of doing it: 
	 Font>>widthOfString: does not works (because it fails to take into account kerning).
	 Why it works on the Editing area is a mystery. 
	 BUT! It does not work for monospaced fonts! (again, no idea why)"
	stringMorph := RubEditingArea new 
		font: aWidget font;
		updateTextWith: string asString.

	width := stringMorph width + 12" min: self currentWorld width / 3".
	self presenter isPropagateNaturalWidth 
		ifTrue: [ aWidget width: width ].

	self presenter isPropagateNaturalHeight 
		ifTrue: [ 
			height := ((stringMorph
				beWrapped;
				width: width;
				yourself) height + 2)"min: self currentWorld height / 3". 
			aWidget height: height ]
]

{ #category : 'initialization' }
SpMorphicTextAdapter >> updateKeyBindings [

	self widgetDo: [ :w | w textArea removeProperty: #kmDispatcher ].
	super updateKeyBindings
]
