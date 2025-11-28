Class {
	#name : 'SpAbstractEasyPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'#contentView',
		'#lastSelectedRow => WeakSlot',
		'#searchBox'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'api - actions' }
SpAbstractEasyPresenter >> actions [

	^ contentView actions
]

{ #category : 'api - actions' }
SpAbstractEasyPresenter >> actions: aSpCommandGroup [

	contentView actions: aSpCommandGroup
]

{ #category : 'api' }
SpAbstractEasyPresenter >> activateOnDoubleClick [

	contentView activateOnDoubleClick
]

{ #category : 'api' }
SpAbstractEasyPresenter >> activateOnSingleClick [

	contentView activateOnSingleClick
]

{ #category : 'private' }
SpAbstractEasyPresenter >> activateSearchWith: aString [

	self isSearchEnabled ifFalse: [ ^ self ].

	"keep last in case we need to go back there (if user cancels)"
	lastSelectedRow := contentView selectedItem.

	searchBox show.
	searchBox text: aString.
	searchBox takeKeyboardFocus.
	searchBox unselectAll.
	searchBox cursorPositionIndex: aString size + 1
]

{ #category : 'api' }
SpAbstractEasyPresenter >> addStyle: aName [

	contentView addStyle: aName
]

{ #category : 'api' }
SpAbstractEasyPresenter >> alternateRowsColor [
	
	contentView alternateRowsColor

]

{ #category : 'api' }
SpAbstractEasyPresenter >> beMultipleSelection [

	contentView beMultipleSelection
]

{ #category : 'api' }
SpAbstractEasyPresenter >> beSingleSelection [

	contentView beSingleSelection
]

{ #category : 'initialization' }
SpAbstractEasyPresenter >> connectPresenters [

	searchBox
		whenTextChangedDo: [ :aString | self selectFirst: aString ];
		whenAcceptedDo: [ self deactivateSearch: true ];
		whenDismissedDo: [ self deactivateSearch: false ].
	
	contentView eventHandler 
		whenKeyDownDo: [ :event | self maybeActivateSearchOn: event ];
		whenFocusReceivedDo: [ :event | searchBox hide ]
]

{ #category : 'private' }
SpAbstractEasyPresenter >> contentView [

	^ contentView
]

{ #category : 'api - actions' }
SpAbstractEasyPresenter >> contextMenuFromCommandsGroup: aValuable [
	
	self actions: aValuable value
]

{ #category : 'private' }
SpAbstractEasyPresenter >> deactivateSearch: acceptSelection [
	| currentSelection |

	currentSelection := contentView selectedItem.
	searchBox hide.
	contentView selectItem: (acceptSelection 
		ifTrue: [ currentSelection ]
		ifFalse: [ lastSelectedRow ]).
	contentView takeKeyboardFocus
]

{ #category : 'transmission' }
SpAbstractEasyPresenter >> defaultInputPort [

	^ self inputItemsPort
]

{ #category : 'layout' }
SpAbstractEasyPresenter >> defaultLayout [

	^ SpOverlayLayout new
		child: (SpBoxLayout newTopToBottom
			add: contentView;
			yourself);
		addOverlay: searchBox withConstraints: [ :c | c vAlignStart; hAlignEnd ];
		yourself
]

{ #category : 'transmission' }
SpAbstractEasyPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : 'api' }
SpAbstractEasyPresenter >> disable [

	self enabled: false
]

{ #category : 'private' }
SpAbstractEasyPresenter >> disableActivationDuring: aBlock [

    contentView disableActivationDuring: aBlock
]

{ #category : 'api' }
SpAbstractEasyPresenter >> disableSearch [
	"Disable searching"

	contentView disableSearch
]

{ #category : 'api' }
SpAbstractEasyPresenter >> enable [

	self enabled: true
]

{ #category : 'api' }
SpAbstractEasyPresenter >> enableSearch [
	"Enable searching"

	contentView enableSearch
]

{ #category : 'private - actions' }
SpAbstractEasyPresenter >> ensureActions [

	^ contentView ensureActions
]

{ #category : 'accessing' }
SpAbstractEasyPresenter >> eventHandler [

	^ contentView eventHandler
]

{ #category : 'initialization' }
SpAbstractEasyPresenter >> initialize [
	
	super initialize.
	self registerEvents
]

{ #category : 'initialization' }
SpAbstractEasyPresenter >> initializePresenters [

	searchBox := self instantiate: SpEasySearchBoxPresenter.
	searchBox hide
]

{ #category : 'transmission' }
SpAbstractEasyPresenter >> inputItemsPort [

	^ (SpListItemsPort newPresenter: self)
		delegateTo: [ contentView ];
		yourself	
]

{ #category : 'testing' }
SpAbstractEasyPresenter >> isActiveOnDoubleClick [
	"Answer true if activation event is triggered on double click"

	^ contentView isActiveOnDoubleClick
]

{ #category : 'testing' }
SpAbstractEasyPresenter >> isActiveOnSingleClick [
	"Answer true if activation event is triggered on single click"

	^ contentView isActiveOnSingleClick
]

{ #category : 'testing' }
SpAbstractEasyPresenter >> isSearchEnabled [
	"Answer true if search is enabled (See `SpTSearchable>>#enableSearch`)"

	^ contentView isSearchEnabled
]

{ #category : 'private' }
SpAbstractEasyPresenter >> maybeActivateSearchOn: event [
		
	self isSearchEnabled ifFalse: [ ^ self ].
	"any modifier other than shift?"
	(event anyModifierKeyPressed 
		or: [ (event keyValue between: 32 and: 127) not ])
		ifTrue: [ ^ self ].
		
	event wasHandled: true.
	"I need to defer it beacuse in morphic this causes the event to 
	 be passed to the box (no idea why)."
	self application defer: [ 
		self activateSearchWith: event keyCharacter asString ]
]

{ #category : 'transmission' }
SpAbstractEasyPresenter >> outputActivationPort [
	
	^ (SpActivationPort newPresenter: self)
		delegateTo: [ contentView ];
		yourself
]

{ #category : 'transmission' }
SpAbstractEasyPresenter >> outputSelectionPort [
	
	^ (SpSelectionPort newPresenter: self)
		delegateTo: [ contentView ];
		yourself
]

{ #category : 'initialization' }
SpAbstractEasyPresenter >> registerEvents [
]

{ #category : 'api' }
SpAbstractEasyPresenter >> removeStyle: aName [

	contentView removeStyle: aName
]

{ #category : 'api' }
SpAbstractEasyPresenter >> searchMatching: aBlock [
	"Enables search and defines a block to perform a search on the model objects. 
	 The block receives two parameters: 
		- item (the model element)
		- pattern (the string to match)"

	contentView searchMatching: aBlock
]

{ #category : 'private' }
SpAbstractEasyPresenter >> selectFirst: aString [

	contentView selectFirst: aString
]

{ #category : 'api' }
SpAbstractEasyPresenter >> styles [

	^ contentView styles
]

{ #category : 'api - events' }
SpAbstractEasyPresenter >> whenActionsChangedDo: aBlock [

	contentView whenActionsChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractEasyPresenter >> whenActivatedDo: aBlock [

	contentView whenActivatedDo: aBlock 
]

{ #category : 'api - events' }
SpAbstractEasyPresenter >> whenSearchEnabledChangedDo: aBlock [
	"Inform when search enabled/disabled has changed.
 	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	contentView whenSearchModeChangedDo: aBlock
]

{ #category : 'api - events' }
SpAbstractEasyPresenter >> whenSelectionChangedDo: aBlock [
	
	contentView whenSelectionChangedDo: aBlock
]
