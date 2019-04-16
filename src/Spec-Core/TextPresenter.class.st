"
I handle basic multi-line text.
See AbstractWidgetPresenter

self example

You can also have a look at ListSelectionPresenter and ScrollSyncExample for more examples.

My main purpose is to handle source code (I have editing shortcuts support).

I provide the following variables and their accessors
- autoAccept is a boolean representing if the text is accepted on each keystroke.
- text is the text of the text zone.

I provide the following methods
- beForCode and beForText are shortcut for configuring me.
- getSelection return the interval currently selected.
- getText is a getter of the text
"
Class {
	#name : #TextPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'textHolder',
		'actionToPerformHolder',
		'readSelectionHolder',
		'actionPerformedHolder',
		'hasUnacceptedEdits',
		'selection',
		'scrollValue',
		'menuHolder',
		'autoAccept',
		'wantsVisualFeedback',
		'askBeforeDiscardingEdits'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
TextPresenter class >> adapterName [

	^ #TextAdapter
]

{ #category : #specs }
TextPresenter class >> title [

	^ 'Text'
]

{ #category : #'api-shout' }
TextPresenter >> aboutToStyle: aBoolean [	
	"<api: #boolean getter: #isAboutToStyle registration: #whenAboutToStyleChanged:>"
	"Set if the text zone must be styled"
	
	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'api-shout' }
TextPresenter >> aboutToStyleBlock [
	"Return the block used to know if the text must be styled"	
	"<api:#inspect>"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8

]

{ #category : #'api-shout' }
TextPresenter >> aboutToStyleBlock: aBlockReturningABoolean [
	"<api: #block getter: #aboutToStyleBlock registration: #whenAboutToStyleBlockChanged:>"
	"Set the block used to know if the text must be styled.
	The block must return a boolean"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8

]

{ #category : #api }
TextPresenter >> accept [
	"<api: #do>"
	"Accep the current pendingtext"
	
	self changed: #accept with: #().
	
	"Dummy changed to raise an announcement"
	actionPerformedHolder value: self text.
]

{ #category : #api }
TextPresenter >> accept: aText notifying: aNotifyier [
	| accept newText |
	
	accept := actionToPerformHolder value cull: aText cull: aNotifyier.
	accept == false ifTrue: [ ^ false ].
	
	newText := aText copy.
	textHolder value: newText.
	
	"Dummy changed to raise an announcement"
	actionPerformedHolder value: newText.
	
	self changed: #clearUserEdits.
	^ true
]

{ #category : #api }
TextPresenter >> acceptBlock [
	"<api: #inspect>"
	"Return the block to perform when the text is accepted.
	The block must have one argument, which will be the accepted text"

	^ actionToPerformHolder value
]

{ #category : #api }
TextPresenter >> acceptBlock: aBlockWithOneArgument [
	"<api: #block getter: #acceptBlock registration: #whenAcceptBlockChanged:>"
	"Set the block to perform when the text is accepted.
	The block must have one argument, which will be the accepted text.
	The block can return false if the candidate text is to be rejected"

	actionToPerformHolder value: aBlockWithOneArgument
]

{ #category : #private }
TextPresenter >> acceptText: aString [
	"Used to set the text value comming from the adapter (we do not want to re-send 
	 this value to the adapter, hence we set it 'raw', not triggering events)"

	textHolder rawValue: aString
]

{ #category : #api }
TextPresenter >> askBeforeDiscardingEdits [

	^ askBeforeDiscardingEdits value
]

{ #category : #api }
TextPresenter >> askBeforeDiscardingEdits: aBoolean [

	askBeforeDiscardingEdits value: aBoolean
]

{ #category : #api }
TextPresenter >> autoAccept [ 
	"Return true if the text is accepted after ech keystroke"
	"<api:#inspect>"
	^ autoAccept value
]

{ #category : #api }
TextPresenter >> autoAccept: aBoolean [
	"<api: #boolean getter: #autoAccept registration: #whenAutoAcceptChanged:>"
	"Set if the text is accepted after each keystroke or not"

	autoAccept value: aBoolean
]

{ #category : #api }
TextPresenter >> beForCode [

	self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8
]

{ #category : #api }
TextPresenter >> beForText [

	self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8
]

{ #category : #'api-shout' }
TextPresenter >> behavior [
	"Return the class corresponding to the method class of the source code you are editing"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'api-shout' }
TextPresenter >> behavior: aClass [
	"Set the class corresponding to the method class of the source code you are editing"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #api }
TextPresenter >> clearSelection [
"	<api: #do>"
   "Remove selection from the text model"

	self setSelection: (0 to: 0)
]

{ #category : #'undo-redo' }
TextPresenter >> clearUndoManager [

	self withAdapterDo: #clearUndoManager
]

{ #category : #api }
TextPresenter >> codePaneMenu: aMenu shifted: shifted [ 
	"Note that unless we override perform:orSendTo:, 
	PluggableTextController will respond to all menu items in a 
	text pane"
	
	^ menuHolder value cull: aMenu cull: shifted
]

{ #category : #'api-doIt' }
TextPresenter >> doItContext [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'api-doIt' }
TextPresenter >> doItContext: anObject [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'api-doIt' }
TextPresenter >> doItReceiver [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'api-doIt' }
TextPresenter >> doItReceiver: anObject [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #api }
TextPresenter >> enabled: aBoolean [

	super enabled: aBoolean.
	self 
		changed: #enabled: 
		with: { aBoolean }
]

{ #category : #focus }
TextPresenter >> eventKeyStrokesForNextFocus [
	"String describing the keystroke to perform to jump to the next widget"
	^ { Character arrowRight command ctrl asKeyCombination }
]

{ #category : #focus }
TextPresenter >> eventKeyStrokesForPreviousFocus [
	"String describing the keystroke to perform to jump to the previous widget"

	^ { Character arrowLeft command ctrl asKeyCombination }
]

{ #category : #private }
TextPresenter >> getMenu [

	self flag: #TODO. "move to menu presenters"
	^ (PragmaMenuBuilder
		pragmaKeyword: self textArea editingModeClass menuKeyword
		model: self widget) 
		menu
]

{ #category : #api }
TextPresenter >> getSelection [
	"<api:#inspect>"
	"Get the text selection"

	selection ifNil: [ ^(1 to: 0) ].
	^ selection value
]

{ #category : #api }
TextPresenter >> getText [
	"<api: #inspect>"
	^ textHolder value
]

{ #category : #api }
TextPresenter >> hasEditingConflicts [
	"<api:#inspect>"
	"Return if the text zone has editing conflicts"

	^ self widget 
		ifNil: [ false ]
		ifNotNil: [:w | w hasEditingConflicts ]
]

{ #category : #api }
TextPresenter >> hasEditingConflicts: aBoolean [
	"Set if the text zone has editing conflicts"
	"<api:#boolean getter: #hasEditingConflicts>"
	
	^ self changed: #hasEditingConflicts: with: { aBoolean }
]

{ #category : #api }
TextPresenter >> hasUnacceptedEdits [
	"<api:#inspect>"
	"Return if the text zone has unaccepted edits (orange corner)"

	hasUnacceptedEdits ifNil: [ ^ false ].
	^ hasUnacceptedEdits value
]

{ #category : #api }
TextPresenter >> hasUnacceptedEdits: aBoolean [
	"Return if the text zone has unaccepted edits (orange corner)"
	"<api:#boolean getter: #hasUnacceptedEdits>"
	hasUnacceptedEdits value: aBoolean
]

{ #category : #initialization }
TextPresenter >> initialize [

	super initialize.

	textHolder := '' asValueHolder.
	actionToPerformHolder := [ :text |  ] asValueHolder.
	readSelectionHolder := [ selection value ] asValueHolder.
	actionPerformedHolder := '' asValueHolder.
	hasUnacceptedEdits := false asValueHolder.
	selection := (1 to: 0) asValueHolder.
	scrollValue := (0 @ 0) asValueHolder.
	menuHolder := [ self getMenu ] asValueHolder.
	autoAccept := false asValueHolder.
	wantsVisualFeedback := true asValueHolder.
	askBeforeDiscardingEdits := true asValueHolder.

	self registerEvents
]

{ #category : #initialization }
TextPresenter >> initializePorts [

	self addInputPort: TextPresenterPort new
]

{ #category : #'api-shout' }
TextPresenter >> isAboutToStyle [
	"Return if the text zone is shouted or not"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #NOCompletion }
TextPresenter >> isCodeCompletionAllowed [
	"Return if code completion is allowed"
	
	"self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8"
		
	^ false
]

{ #category : #api }
TextPresenter >> isCodeCompletionAllowed: aBoolean [
	"<api: #boolean getter: #isCodeCompletionAllowed registration: #whenCodeCompletionAllowedChanged:>"
	"Set if code completion is allowed"
	
	"self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8"
]

{ #category : #api }
TextPresenter >> isForSmalltalkCode [

	"self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8"

	^ false
]

{ #category : #api }
TextPresenter >> isForSmalltalkCode: aBoolean [
	
	"self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8"
]

{ #category : #api }
TextPresenter >> menuHolder [
	"<api: #inspect>"
	"Return the block used to calculate the text selection"

	^ menuHolder value
]

{ #category : #api }
TextPresenter >> menuHolder: aBlock [
	"<api: #block getter: #menuHolder registration: #whenMenuHolderChanged:>"
	"Set the block used to compute the menu"

	^ menuHolder value:  aBlock
]

{ #category : #'api-errors' }
TextPresenter >> notify: errorMessage at: position in: sourceCode [

	self changed: #notify:at:in: with: { errorMessage . position . sourceCode }
]

{ #category : #api }
TextPresenter >> readSelection [
	"<api: #inspect>"
	^ readSelectionHolder value cull: self text cull: self
]

{ #category : #api }
TextPresenter >> readSelectionBlock [
	"<api: #inspect>"
	"Return the block used to calculate the text selection"

	^ readSelectionHolder value
]

{ #category : #api }
TextPresenter >> readSelectionBlock: aBlock [
	"<api: #block getter: #readSelectionBlock registration: #whenReadSelectionIsChanged:>"
	"Set the block used to calculate the text selection"

	^ readSelectionHolder value: aBlock
]

{ #category : #initialization }
TextPresenter >> registerEvents [

	textHolder whenChangedDo: [ self changed: #getText ].
	readSelectionHolder whenChangedDo: [ self changed: #readSelection ].
	hasUnacceptedEdits whenChangedDo: [ :bool | self changed: #setHasUnacceptedEdits: with: { bool } ].
	selection whenChangedDo: [:block | self changed: #setSelectionFromModel: with: { block value } ].
	scrollValue whenChangedDo: [ :newPosition | self changed: #setScrollValue: with: { newPosition } ].
	autoAccept whenChangedDo: [:bool | self changed: #autoAccept: with: { bool } ].
	wantsVisualFeedback whenChangedDo: [ :bool | self changed: #changed with: #() ].
	askBeforeDiscardingEdits whenChangedDo: [ :bool | self changed: #askBeforeDiscardingEdits: with: { bool } ].
]

{ #category : #api }
TextPresenter >> scrollValue [
	"<api: #inspect>"
	"Return the current scroll position"

	^ scrollValue value
]

{ #category : #api }
TextPresenter >> scrollValue: aPoint [
	"<api: #point getter: #scrollValue registration: #whenScrollValuehanged:>"
	"Set the scroll position"

	^ scrollValue value: aPoint
]

{ #category : #api }
TextPresenter >> selectAll [
	
	self changed: #selectAll with: #()
]

{ #category : #api }
TextPresenter >> selectedBehavior [

	^ behaviorHolder value
]

{ #category : #NOCompletion }
TextPresenter >> selectedClassOrMetaClass [

	^ self behavior
]

{ #category : #api }
TextPresenter >> setSelection: anInterval [
	"Set the text selection without changing the readSelectionBlock"
	"<api: #st getter: #getSelection>"

	selection ifNotNil: [: holder | holder value: anInterval ]
]

{ #category : #api }
TextPresenter >> setSelectionInterval: anInterval [
	selection rawValue: anInterval
]

{ #category : #api }
TextPresenter >> text [

	^ self getText
]

{ #category : #api }
TextPresenter >> text: aText [
	"<api: #string getter: #getText registration: #whenTextChanged:>"
	"Set the text of the text zone"
	
	textHolder value: aText
]

{ #category : #private }
TextPresenter >> textArea [
	^ self adapter widget
]

{ #category : #simulating }
TextPresenter >> type: aString [ 
	"For simulation: Do as if we type the given string"
	self text: aString
]

{ #category : #api }
TextPresenter >> wantsVisualFeedback [

	^ wantsVisualFeedback value
]

{ #category : #api }
TextPresenter >> wantsVisualFeedback: aBoolean [

	wantsVisualFeedback value: aBoolean
]

{ #category : #'api-events' }
TextPresenter >> whenAboutToStyleBlockChangedDo: aBlock [
	"Set a block to perform when the about to style block changed"
	
	aboutToStyleHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
TextPresenter >> whenAboutToStyleChangedDo: aBlock [
	"<api: #event>"
	"Set a block to perform when the about to style block changed"
	
	self whenAboutToStyleBlockChanged: [:block :old :announcement :anAnnouncer | 
		aBlock cull: (block value) cull: old cull: announcement cull: anAnnouncer ]
]

{ #category : #'api-events' }
TextPresenter >> whenAcceptBlockChangedDo: aBlock [
	"Set a block to perform when the accept block changed"
	
	actionToPerformHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
TextPresenter >> whenAutoAcceptChangedDo: aBlock [
	"aBlock will be performed when autoAccept changed"
	
	autoAccept whenChangedDo: aBlock
]

{ #category : #'api-events' }
TextPresenter >> whenBehaviorChangedDo: aBlock [
	"Set a block to perform when the behavior class changed"
	
	behaviorHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
TextPresenter >> whenCodeCompletionAllowedChangedDo: aBlock [
	"Set a block to perform when the code completion value changed"
	
	actionPerformedHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
TextPresenter >> whenMenuHolderChangedDo: aBlock [
	"Set a block to perform when the block use to build menu changed"
	
	menuHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
TextPresenter >> whenReadSelectionIsChangedDo: aBlock [
	"Set a block to perform when the read selection block changed"
	
	readSelectionHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
TextPresenter >> whenScrollValueChangedDo: aBlock [
	"Set a block to perform when the scroll value changed"
	
	scrollValue whenChangedDo: aBlock
]

{ #category : #'api-events' }
TextPresenter >> whenTextChangedDo: aBlock [
	"Set a block to perform when the text changed"
	
	textHolder whenChangedDo: aBlock
]

{ #category : #'api-events' }
TextPresenter >> whenTextIsAcceptedDo: aBlock [
	"Set a block to perform when the text is accepted"
	
	actionPerformedHolder whenChangedDo: aBlock
]
