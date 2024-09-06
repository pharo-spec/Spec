"
A base for text presenters, it defines basic functionality common to all texts.

"
Class {
	#name : 'SpAbstractTextPresenter',
	#superclass : 'SpAbstractWidgetPresenter',
	#traits : 'SpTContextMenu',
	#classTraits : 'SpTContextMenu classTrait',
	#instVars : [
		'#selection => ObservableSlot',
		'#text => ObservableSlot',
		'#actionToPerform => ObservableSlot',
		'#readSelection => ObservableSlot',
		'#placeholder => ObservableSlot',
		'#editable => ObservableSlot'
	],
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'testing' }
SpAbstractTextPresenter class >> isAbstract [
	^ self = SpAbstractTextPresenter
]

{ #category : 'private' }
SpAbstractTextPresenter >> acceptText: aString [
	"Used to set the text value comming from the adapter (we do not want to re-send 
	 this value to the adapter, hence we set it 'raw', not triggering events)"

	self property: #text rawValue: aString
]

{ #category : 'api' }
SpAbstractTextPresenter >> beEditable [
	"Allow edition (deny readonly)."

	self editable: true
]

{ #category : 'api' }
SpAbstractTextPresenter >> beNotEditable [
	"Set content text as not editable (readonly)"

	self editable: false
]

{ #category : 'api' }
SpAbstractTextPresenter >> clearContent [
	"Clear current presenter contents"

	self text: ''
]

{ #category : 'api' }
SpAbstractTextPresenter >> clearSelection [
	"Remove selection from the text model"

	self selectionInterval: (0 to: 0)
]

{ #category : 'api' }
SpAbstractTextPresenter >> clearUndoManager [
	"Clear undo manager contents"

	self flag: #TODO. "Maybe remove?"
	self withAdapterDo: [ :anAdapter | 
		anAdapter clearUndoManager ]
]

{ #category : 'api' }
SpAbstractTextPresenter >> cursorPositionIndex [
	"Answer the index (position in the string) of the cursor (or nil if the cursor is nowhere)"
	
	^ self withAdapterDo: [ :anAdapter |
		anAdapter cursorPositionIndex ]
]

{ #category : 'api' }
SpAbstractTextPresenter >> cursorPositionIndex: index [
	"Set cursor position index. 
	 This method will place the cursor in the text index position requested."

 	^ self withAdapterDo: [ :anAdapter | anAdapter cursorPositionIndex: index ]
]

{ #category : 'private' }
SpAbstractTextPresenter >> editable: aBoolean [

	editable := aBoolean
]

{ #category : 'TOREMOVE' }
SpAbstractTextPresenter >> hasEditingConflicts [
	"Return if the text zone has editing conflicts"

	^ self widget 
		ifNil: [ false ]
		ifNotNil: [:w | w hasEditingConflicts ]
]

{ #category : 'initialization' }
SpAbstractTextPresenter >> initialize [
	super initialize.

	text := ''.
	placeholder := ''.
	actionToPerform := [ :txt |  ].
	readSelection := [ selection ].
	selection := 1 to: 0.

	self registerEvents.
	self registerActions
]

{ #category : 'api' }
SpAbstractTextPresenter >> insert: aString at: positionIndex [
	"insert `aString` into the text contents at `positionIndex`"
	
	self withAdapterDo: [ :anAdapter |
		anAdapter insert: aString at: positionIndex ]
]

{ #category : 'api' }
SpAbstractTextPresenter >> insertAndSelectAfterCurrentSelection: aString [
	"Insert `aString` at the end of current selection and select the inserted text."
	| selectionInterval |

	self flag: #TODO. "Does this really has to be part of the text api?"
	selectionInterval := self selectionInterval.
	self insert: aString at: selectionInterval last.
	self selectionInterval: (selectionInterval last + 1 to: selectionInterval last + aString size)
]

{ #category : 'testing' }
SpAbstractTextPresenter >> isEditable [

	^ self subclassResponsibility
]

{ #category : 'TOREMOVE' }
SpAbstractTextPresenter >> isForSmalltalkCode [

	"self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8"

	^ false
]

{ #category : 'TOREMOVE' }
SpAbstractTextPresenter >> isForSmalltalkCode: aBoolean [
	
	"self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8"
]

{ #category : 'localization' }
SpAbstractTextPresenter >> localeChanged [

	super localeChanged.
	self forceUpdateSlot: #placeholder
	
]

{ #category : 'TOREMOVE' }
SpAbstractTextPresenter >> notify: errorMessage at: position in: sourceCode [

	self changed: #notify:at:in: with: { errorMessage . position . sourceCode }
]

{ #category : 'api' }
SpAbstractTextPresenter >> placeholder [
	"Answer the place holder (also known as ghost text) for this text component."

	^ placeholder
]

{ #category : 'api' }
SpAbstractTextPresenter >> placeholder: aString [
	"Set the place holder (also known as ghost text) for this text component."

	placeholder := aString
]

{ #category : 'private' }
SpAbstractTextPresenter >> rawSelection: anInterval [

	self property: #selection rawValue: anInterval
]

{ #category : 'private' }
SpAbstractTextPresenter >> readSelection [

	^ self readSelectionBlock 
		cull: self text 
		cull: self
]

{ #category : 'TOREMOVE' }
SpAbstractTextPresenter >> readSelectionBlock [
	"Return the block used to calculate the text selection"

	^ readSelection
]

{ #category : 'TOREMOVE' }
SpAbstractTextPresenter >> readSelectionBlock: aBlock [
	"Set the block used to calculate the text selection"

	^ readSelection := aBlock
]

{ #category : 'initialization' }
SpAbstractTextPresenter >> registerActions [

	self addShortcutWith: [ :action | action
		shortcutKey: $t actionModifier;
		action: [ self showContextMenu ] ]
]

{ #category : 'initialization' }
SpAbstractTextPresenter >> registerEvents [

	self whenTextChangedDo: [ self changed: #getText ].
	self 
		property: #selection 
		whenChangedDo: [ :aSelection | self updateSelectionFromModel: aSelection ]
]

{ #category : 'api - selection' }
SpAbstractTextPresenter >> selectAll [
	"Select all text"
	
	self withAdapterDo: [ :anAdapter | anAdapter selectAll ]
]

{ #category : 'api - selection' }
SpAbstractTextPresenter >> selectLine [
	"Select line where the cursor is placed at this moment and answer the resulting selection 
	(See `SpAbstractTextPresenter>>#selectionInterval`). "

	self withAdapterDo: [ :anAdapter | anAdapter selectLine ].
	^ self selectionInterval
]

{ #category : 'TOREMOVE' }
SpAbstractTextPresenter >> selectedClassOrMetaClass [

	^ self behavior
]

{ #category : 'api - selection' }
SpAbstractTextPresenter >> selectedText [ 
	"Answer the text contained in selection interval 
	(See `SpAbstractTextPresenter>>#selectionInterval`)"
	| selectionInterval |
	
	selectionInterval := self selectionInterval.
	selectionInterval ifEmpty: [ ^ '' ].
	
	^ self text asString
		copyFrom: selectionInterval first 
		to: selectionInterval last
]

{ #category : 'api - selection' }
SpAbstractTextPresenter >> selectionInterval [
	"Answer the text selection interval (an interval from start to end)."
	
	self withAdapterDo: [ :anAdapter | 
		self rawSelection: anAdapter selection ].
	^ selection ifNil: [ 1 to: 0 ]
]

{ #category : 'api - selection' }
SpAbstractTextPresenter >> selectionInterval: anInterval [
	"Set the text selection interval.
	 `anInterval` is an `Interval` from the first character selected to the end."
	
	self flag: #REVIEW. "Maybe it should be called #selectInterval:?"
	selection := anInterval
]

{ #category : 'api' }
SpAbstractTextPresenter >> text [
	"Answer current text"

	^ text
]

{ #category : 'api' }
SpAbstractTextPresenter >> text: aString [
	"Set the text of the text presenter"

	text := aString
]

{ #category : 'simulating' }
SpAbstractTextPresenter >> type: aString [ 
	"For simulation: Do as if we type the given string"
	self withAdapterDo: [ :anAdapter | 
		anAdapter type: aString.
		^ self ].

	self text: aString
]

{ #category : 'simulating' }
SpAbstractTextPresenter >> typeByChar: aString [ 
	"For simulation: Do as if we type the given string"
	self withAdapterDo: [ :anAdapter | 
		anAdapter typeByChar: aString.
		^ self ].

	self isEditable ifFalse: [ ^ self ].
	aString do: [ :each | 
		self text: (self text ifNil: [ '' ]), (each asString) ]
]

{ #category : 'api - selection' }
SpAbstractTextPresenter >> unselectAll [
	"Unselect text"
	
	self selectionInterval: (1 to: 0)
]

{ #category : 'private' }
SpAbstractTextPresenter >> updateSelectionFromModel: aSelection [

	self withAdapterDo: [ :anAdapter | 
		anAdapter setSelectionFromModel: aSelection ]
]

{ #category : 'api - events' }
SpAbstractTextPresenter >> whenEditableChangedDo: aBlock [
	"Inform when editable property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #editable whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractTextPresenter >> whenPlaceholderChangedDo: aBlock [
	"Inform when placeholder has been changed (See `SpAbstractTextPresenter>>#placeholder:`).
	 `aBlock` receives two optional arguments 
	 - new placeholder
	 - old placeholder"
	
	self property: #placeholder whenChangedDo: aBlock
]

{ #category : 'private' }
SpAbstractTextPresenter >> whenReadSelectionIsChangedDo: aBlock [
	"Set a block to perform when the read selection block changed"

	self property: #readSelection whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractTextPresenter >> whenResetDo: aBlock [
	"Inform when a 'reset' event is triggered.
	 It will react when user presses <meta+l> key (this is for historical reasons)."

	self 
		bindKeyCombination: SpCancelChangesCommand defaultShortcutKey
		toAction: aBlock
]

{ #category : 'api - events' }
SpAbstractTextPresenter >> whenSelectionChangedDo: aBlock [
	"Inform when selection changed. 
	 `aBlock` receives two optional arguments 
	 - new selection
	 - old selection"

	self property: #selection whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractTextPresenter >> whenSubmitDo: aBlock [
	"Inform a 'submit' event has been triggered. 
	 It will react when user presses <meta+s> key (this is for historical reasons) and (in case of text fields) with <cr>.
	 `aBlock` receives one argument (the submited text)"

	self subclassResponsibility
]

{ #category : 'api - events' }
SpAbstractTextPresenter >> whenTextChangedDo: aBlock [
	"Inform when text has been changed (a character has been enter or `SpAbstractTextPresenter>>text:` has been called)
	 `aBlock` receives two optional arguments 
	 - new text
	 - old text"

	self property: #text whenChangedDo: aBlock
]
