Class {
	#name : #SpAbstractTextPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#traits : 'SpTContextMenu',
	#classTraits : 'SpTContextMenu classTrait',
	#instVars : [
		'#hasUnacceptedEdits => SpObservableSlot',
		'#selection => SpObservableSlot',
		'#autoAccept => SpObservableSlot',
		'#wantsVisualFeedback => SpObservableSlot',
		'#askBeforeDiscardingEdits => SpObservableSlot',
		'#text => SpObservableSlot',
		'#actionToPerform => SpObservableSlot',
		'#readSelection => SpObservableSlot',
		'#actionPerformed => SpObservableSlot',
		'#placeholder => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets'
}

{ #category : #testing }
SpAbstractTextPresenter class >> isAbstract [
	^ self = SpAbstractTextPresenter
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> aboutToStyle: aBoolean [
	"Set if the text zone must be styled"
	
	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> aboutToStyleBlock [
	"Return the block used to know if the text must be styled"	

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8

]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> aboutToStyleBlock: aBlockReturningABoolean [
	"Set the block used to know if the text must be styled.
	The block must return a boolean"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8

]

{ #category : #api }
SpAbstractTextPresenter >> accept [
	"Accep the current pendingtext"

	self changed: #accept with: #().

	"Raise an announcement"
	self actionPerformed
]

{ #category : #api }
SpAbstractTextPresenter >> acceptBlock [
	"Return the block to perform when the text is accepted.
	The block must have one argument, which will be the accepted text"

	^ actionToPerform
]

{ #category : #api }
SpAbstractTextPresenter >> acceptBlock: aBlockWithOneArgument [
	"Set the block to perform when the text is accepted.
	The block must have one argument, which will be the accepted text.
	The block can return false if the candidate text is to be rejected"

	actionToPerform := aBlockWithOneArgument
]

{ #category : #private }
SpAbstractTextPresenter >> acceptText: aString [
	"Used to set the text value comming from the adapter (we do not want to re-send 
	 this value to the adapter, hence we set it 'raw', not triggering events)"

	self property: #text rawValue: aString
]

{ #category : #private }
SpAbstractTextPresenter >> actionPerformed [

	actionPerformed := self text
]

{ #category : #api }
SpAbstractTextPresenter >> askBeforeDiscardingEdits [
	^ askBeforeDiscardingEdits
]

{ #category : #api }
SpAbstractTextPresenter >> askBeforeDiscardingEdits: aBoolean [
	askBeforeDiscardingEdits := aBoolean
]

{ #category : #api }
SpAbstractTextPresenter >> autoAccept [
	"Return true if the text is accepted after ech keystroke"

	^ autoAccept
]

{ #category : #api }
SpAbstractTextPresenter >> autoAccept: aBoolean [
	"Set if the text is accepted after each keystroke or not"

	autoAccept := aBoolean
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> beForCode [

	self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> beForText [

	self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> behavior [
	"Return the class corresponding to the method class of the source code you are editing"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> behavior: aClass [
	"Set the class corresponding to the method class of the source code you are editing"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #api }
SpAbstractTextPresenter >> clearContent [
	self text: ''
]

{ #category : #api }
SpAbstractTextPresenter >> clearSelection [
	"Remove selection from the text model"

	self selectionInterval: (0 to: 0)
]

{ #category : #'undo-redo' }
SpAbstractTextPresenter >> clearUndoManager [

	self withAdapterDo: [ :anAdapter | anAdapter clearUndoManager ]
]

{ #category : #api }
SpAbstractTextPresenter >> cursorPositionIndex [
	
	^self withAdapterDo: [ :anAdapter |
		anAdapter cursorPositionIndex ]
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> doItContext [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> doItContext: anObject [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> doItReceiver [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> doItReceiver: anObject [

	self 
		deprecated: 'This has been moved to specific presenters (check children)' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #api }
SpAbstractTextPresenter >> enabled: aBoolean [

	super enabled: aBoolean.
	self 
		changed: #enabled: 
		with: { aBoolean }
]

{ #category : #focus }
SpAbstractTextPresenter >> eventKeyStrokesForNextFocus [
	"String describing the keystroke to perform to jump to the next widget"
	^ { Character arrowRight command ctrl asKeyCombination }
]

{ #category : #focus }
SpAbstractTextPresenter >> eventKeyStrokesForPreviousFocus [
	"String describing the keystroke to perform to jump to the previous widget"

	^ { Character arrowLeft command ctrl asKeyCombination }
]

{ #category : #private }
SpAbstractTextPresenter >> getMenu [
	self flag: #TODO.	"move to menu presenters"
	^ (PragmaMenuBuilder
		pragmaKeyword: self textArea editingModeClass menuKeyword
		model: self adapter) menu
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> getSelection [
	"Get the text selection"
	
	self 
		deprecated: 'Use #selection instead.' 
		transformWith: '`@receiver getSelection' 
		            -> '`@receiver selection'.
		
	^ self selection
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> getText [
	self deprecated: 'Use #text instead' transformWith: '`@receiver getText' -> '`@receiver text'.
	^ self text
]

{ #category : #api }
SpAbstractTextPresenter >> hasEditingConflicts [
	"Return if the text zone has editing conflicts"

	^ self widget 
		ifNil: [ false ]
		ifNotNil: [:w | w hasEditingConflicts ]
]

{ #category : #api }
SpAbstractTextPresenter >> hasEditingConflicts: aBoolean [
	"Set if the text zone has editing conflicts"
	
	^ self changed: #hasEditingConflicts: with: { aBoolean }
]

{ #category : #api }
SpAbstractTextPresenter >> hasUnacceptedEdits [
	"Return if the text zone has unaccepted edits (orange corner)"

	^ hasUnacceptedEdits
]

{ #category : #api }
SpAbstractTextPresenter >> hasUnacceptedEdits: aBoolean [
	"Return if the text zone has unaccepted edits (orange corner)"

	hasUnacceptedEdits := aBoolean
]

{ #category : #initialization }
SpAbstractTextPresenter >> initialize [
	super initialize.

	text := ''.
	placeholder := ''.
	actionToPerform := [ :txt |  ].
	readSelection := [ selection ].
	actionPerformed := ''.
	hasUnacceptedEdits := false.
	selection := 1 to: 0.
	autoAccept := false.
	wantsVisualFeedback := true.
	askBeforeDiscardingEdits := true.

	self registerEvents
]

{ #category : #api }
SpAbstractTextPresenter >> insert: aString at: positionIndex [
	"inserts aString into the text string. 
	 positionIndex indicates the position index (as in #indexOf) the insertion."
	
	self withAdapterDo: [ :anAdapter |
		anAdapter insert: aString at: positionIndex ]
]

{ #category : #api }
SpAbstractTextPresenter >> insertAndSelectAfterCurrentSelection: aString [
	| selectionInterval |
	selectionInterval := self selectionInterval.
	self insert: aString at: selectionInterval last + 1.
	self selectionInterval: (selectionInterval last + 1 to: selectionInterval last + aString size)
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> isAboutToStyle [
	"Return if the text zone is shouted or not"

	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #api }
SpAbstractTextPresenter >> isForSmalltalkCode [

	"self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8"

	^ false
]

{ #category : #api }
SpAbstractTextPresenter >> isForSmalltalkCode: aBoolean [
	
	"self 
		deprecated: 'The forCode functionality has moved to TextCodePresenter, please use it instead TextPresenter.' 
		on: '2019-04-05' 
		in: #Pharo8"
]

{ #category : #'api-errors' }
SpAbstractTextPresenter >> notify: errorMessage at: position in: sourceCode [

	self changed: #notify:at:in: with: { errorMessage . position . sourceCode }
]

{ #category : #api }
SpAbstractTextPresenter >> placeholder [

	^ placeholder
]

{ #category : #accessing }
SpAbstractTextPresenter >> placeholder: aText [

	placeholder := aText
]

{ #category : #private }
SpAbstractTextPresenter >> rawSelection: anInterval [
	self property: #selection rawValue: anInterval
]

{ #category : #api }
SpAbstractTextPresenter >> readSelection [
	^ self readSelectionBlock cull: self text cull: self
]

{ #category : #api }
SpAbstractTextPresenter >> readSelectionBlock [
	"Return the block used to calculate the text selection"

	^ readSelection
]

{ #category : #api }
SpAbstractTextPresenter >> readSelectionBlock: aBlock [
	"Set the block used to calculate the text selection"

	^ readSelection := aBlock
]

{ #category : #initialization }
SpAbstractTextPresenter >> registerEvents [
	self whenTextChangedDo: [ self changed: #getText ].
	self whenReadSelectionIsChangedDo: [ self changed: #readSelection ].
	self property: #hasUnacceptedEdits whenChangedDo: [ :bool | self changed: #setHasUnacceptedEdits: with: {bool} ].
	self property: #selection whenChangedDo: [ :block | self changed: #setSelectionFromModel: with: {block value} ].
	self whenAutoAcceptChangedDo: [ :bool | self changed: #autoAccept: with: {bool} ].
	self property: #wantsVisualFeedback whenChangedDo: [ :bool | self changed: #changed with: #() ].
	self property: #askBeforeDiscardingEdits whenChangedDo: [ :bool | self changed: #askBeforeDiscardingEdits: with: {bool} ]
]

{ #category : #api }
SpAbstractTextPresenter >> selectAll [
	
	self changed: #selectAll with: #()
]

{ #category : #api }
SpAbstractTextPresenter >> selectLine [
	self withAdapterDo: [ :anAdapter | anAdapter selectLine ].
	^ self selectionInterval
]

{ #category : #NOCompletion }
SpAbstractTextPresenter >> selectedClassOrMetaClass [

	^ self behavior
]

{ #category : #api }
SpAbstractTextPresenter >> selectedText [ 
	|selectionInterval|
	selectionInterval := self selectionInterval ifEmpty: [ ^'' ].
	^self text copyFrom: selectionInterval first to: selectionInterval last
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> selection [
	self
		deprecated:
			'#selection was used to return an interval, and did not convey the correct meaning. Use #selectionInterval instead.'
		transformWith: '`@receiver selection' -> '`@receiver selectionInterval'.
	^ self selectionInterval
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> selection: anInterval [
	self
		deprecated:
			'#selection: was used to set an interval, and did not convey the correct meaning. Use #selectionInterval: instead.'
		transformWith: '`@receiver selection: `@arg' -> '`@receiver selectionInterval: `@arg'.
	self selectionInterval: anInterval
]

{ #category : #api }
SpAbstractTextPresenter >> selectionInterval [
	"Get the text selection interval.
	 I will update the selection from adapter first"
	
	self withAdapterDo: [ :anAdapter | 
		self rawSelection: anAdapter selection ].
	^ selection ifNil: [ ^ 1 to: 0 ]
]

{ #category : #api }
SpAbstractTextPresenter >> selectionInterval: anInterval [
	"Set the text selection interval without changing the readSelectionBlock"

	selection := anInterval
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> setSelection: anInterval [
	"Set the text selection without changing the readSelectionBlock"

	self
		deprecated: 'Use #selection: instead.'
		transformWith:
			'`@receiver setSelection: `@statement'
				-> '`@receiver selection: `@statement'.
	self selectionInterval: anInterval
]

{ #category : #api }
SpAbstractTextPresenter >> text [

	^ text
]

{ #category : #api }
SpAbstractTextPresenter >> text: aText [
	"Set the text of the text zone"

	text := aText
]

{ #category : #private }
SpAbstractTextPresenter >> textArea [
	
	self flag: #REMOVEME.
	^ self adapter widget
]

{ #category : #simulating }
SpAbstractTextPresenter >> type: aString [ 
	"For simulation: Do as if we type the given string"
	self text: aString
]

{ #category : #api }
SpAbstractTextPresenter >> wantsVisualFeedback [
	^ wantsVisualFeedback
]

{ #category : #api }
SpAbstractTextPresenter >> wantsVisualFeedback: aBoolean [
	wantsVisualFeedback := aBoolean
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAboutToStyleBlockChanged: aBlock [
	self deprecated: 'Use #whenAboutToStyleBlockChangedDo: instead.' transformWith: '`@receiver whenAboutToStyleBlockChanged: `@statements' -> '`@receiver whenAboutToStyleBlockChangedDo: `@statements'.
	self whenAboutToStyleBlockChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAboutToStyleBlockChangedDo: aBlock [
	"Set a block to perform when the about to style block changed"
	
	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAboutToStyleChanged: aBlock [
	self deprecated: 'Use #whenAboutToStyleChangedDo: instead.' transformWith: '`@receiver whenAboutToStyleChanged: `@statements' -> '`@receiver whenAboutToStyleChangedDo: `@statements'.
	self whenAboutToStyleChangedDo: aBlock
]

{ #category : #'api-events' }
SpAbstractTextPresenter >> whenAboutToStyleChangedDo: aBlock [
	"Set a block to perform when the about to style block changed"
	
	self whenAboutToStyleBlockChanged: [:block :old :announcement :anAnnouncer | 
		aBlock cull: (block value) cull: old cull: announcement cull: anAnnouncer ]
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAcceptBlockChanged: aBlock [
	self deprecated: 'Use #whenAcceptBlockChangedDo: instead.' transformWith: '`@receiver whenAcceptBlockChanged: `@statements' -> '`@receiver whenAcceptBlockChangedDo: `@statements'.
	self whenAcceptBlockChangedDo: aBlock
]

{ #category : #'api-events' }
SpAbstractTextPresenter >> whenAcceptBlockChangedDo: aBlock [
	"Set a block to perform when the accept block changed"
	
	self property: #actionToPerform whenChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenAutoAcceptChanged: aBlock [
	self deprecated: 'Use #whenAutoAcceptChangedDo: instead.' transformWith: '`@receiver whenAutoAcceptChanged: `@statements' -> '`@receiver whenAutoAcceptChangedDo: `@statements'.
	self whenAutoAcceptChangedDo: aBlock
]

{ #category : #'api-events' }
SpAbstractTextPresenter >> whenAutoAcceptChangedDo: aBlock [
	"aBlock will be performed when autoAccept changed"

	self property: #autoAccept whenChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenBehaviorChanged: aBlock [
	self deprecated: 'Use #whenBehaviorChangedDo: instead.' transformWith: '`@receiver whenBehaviorChanged: `@statements' -> '`@receiver whenBehaviorChangedDo: `@statements'.
	self whenBehaviorChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenBehaviorChangedDo: aBlock [
	"Set a block to perform when the behavior class changed"
	
	self 
		deprecated: 'This has been moved to specific presenters' 
		on: '2019-04-15'
		in: #Pharo8
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenCodeCompletionAllowedChanged: aBlock [
	self
		deprecated: 'Use #whenTextIsAcceptedDo: instead or nothing. Currently, both those methods are doing the same thing but my name is really missleading. Thus, I''ll be removed.'
		transformWith: '`@receiver whenCodeCompletionAllowedChanged: `@statements' -> '`@receiver whenTextIsAcceptedDo: `@statements'.
	self whenTextIsAcceptedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenCodeCompletionAllowedChangedDo: aBlock [
	self
		deprecated: 'Use #whenTextIsAcceptedDo: instead or nothing. Currently, both those methods are doing the same thing but my name is really missleading. Thus, I''ll be removed.'
		transformWith: '`@receiver whenCodeCompletionAllowedChangedDo: `@statements' -> '`@receiver whenTextIsAcceptedDo: `@statements'.

	self whenTextIsAcceptedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenMenuHolderChanged: aBlock [
	self deprecated: 'Use #whenMenuHolderChangedDo: instead.' transformWith: '`@receiver whenMenuHolderChanged: `@statements' -> '`@receiver whenMenuHolderChangedDo: `@statements'.
	self whenMenuHolderChangedDo: aBlock
]

{ #category : #'api-events' }
SpAbstractTextPresenter >> whenPlaceholderChangedDo: aBlock [
	
	self property: #placeholder whenChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenReadSelectionIsChanged: aBlock [
	self deprecated: 'Use #whenReadSelectionIsChangedDo: instead.' transformWith: '`@receiver whenReadSelectionIsChanged: `@statements' -> '`@receiver whenReadSelectionIsChangedDo: `@statements'.
	self whenReadSelectionIsChangedDo: aBlock
]

{ #category : #'api-events' }
SpAbstractTextPresenter >> whenReadSelectionIsChangedDo: aBlock [
	"Set a block to perform when the read selection block changed"

	self property: #readSelection whenChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenScrollValueChanged: aBlock [
	self deprecated: 'Use #whenScrollValueChangedDo: instead.' transformWith: '`@receiver whenScrollValueChanged: `@statements' -> '`@receiver whenScrollValueChangedDo: `@statements'.
	self whenScrollValueChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenTextChanged: aBlock [
	self deprecated: 'Use #whenTextChangedDo: instead.' transformWith: '`@receiver whenTextChanged: `@statement' -> '`@receiver whenTextChangedDo: `@statement'.
	self whenTextChangedDo: aBlock
]

{ #category : #'api-events' }
SpAbstractTextPresenter >> whenTextChangedDo: aBlock [
	"Set a block to perform when the text changed"

	self property: #text whenChangedDo: aBlock
]

{ #category : #'Spec2-Deprecated' }
SpAbstractTextPresenter >> whenTextIsAccepted: aBlock [
	self deprecated: 'Use #whenTextIsAcceptedDo: instead.' transformWith: '`@receiver whenTextIsAccepted: `@statements' -> '`@receiver whenTextIsAcceptedDo: `@statements'.
	self whenTextIsAcceptedDo: aBlock
]

{ #category : #'api-events' }
SpAbstractTextPresenter >> whenTextIsAcceptedDo: aBlock [
	"Set a block to perform when the text is accepted"
	
	self property: #actionPerformed whenChangedDo: aBlock
]
