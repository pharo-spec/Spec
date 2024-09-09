Class {
	#name : 'SpAbstractEasyPresenter',
	#superclass : 'SpPresenter',
	#traits : 'SpTSearchable',
	#classTraits : 'SpTSearchable classTrait',
	#instVars : [
		'#contentView',
		'#searchInput',
		'#lastSelectedRow => WeakSlot'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

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

	lastSelectedRow := contentView selectedItem.

	searchInput text: aString.
	searchInput show.
	searchInput takeKeyboardFocus.
	searchInput unselectAll.
	searchInput cursorPositionIndex: aString size
]

{ #category : 'api - actions' }
SpAbstractEasyPresenter >> addAction: aSpCommand [

	contentView addAction: aSpCommand
]

{ #category : 'api - actions' }
SpAbstractEasyPresenter >> addActionGroup: aSpCommandGroup [

	contentView addActionGroup: aSpCommandGroup
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

	searchInput 
		addAction: (SpAction
			newShortcut: Character escape asKeyCombination 
			action: [ self deactivateSearch: false ]);
		addAction: (SpAction
			newShortcut: Character cr asKeyCombination 
			action: [ self deactivateSearch: true ]);
		whenTextChangedDo: [ :aString | self selectFirst: aString ].
	
	contentView eventHandler 
		whenKeyDownDo: [ :event | self maybeActivateSearchOn: event ];
		whenFocusReceivedDo: [ :event | searchInput hide ]
]

{ #category : 'api - actions' }
SpAbstractEasyPresenter >> contextMenuFromCommandsGroup: aValuable [
	
	self flag: #TODO.
	"this is not really to be used... we have now actionGroup: :P"
]

{ #category : 'private' }
SpAbstractEasyPresenter >> deactivateSearch: acceptSelection [
	| currentSelection |

	currentSelection := contentView selectedItem.
	searchInput hide.
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
		child: contentView;
		addOverlay: searchInput withConstraints: [ :c | c vAlignStart; hAlignEnd ];
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

{ #category : 'api' }
SpAbstractEasyPresenter >> enable [

	self enabled: true
]

{ #category : 'initialization' }
SpAbstractEasyPresenter >> initialize [
	
	super initialize.
	self initializeTSearchable.
	self registerEvents
]

{ #category : 'initialization' }
SpAbstractEasyPresenter >> initializePresenters [

	searchInput := self newTextInput.
	searchInput hide
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

{ #category : 'private' }
SpAbstractEasyPresenter >> maybeActivateSearchOn: event [
		
	self isSearchEnabled ifFalse: [ ^ self ].
	"any modifier other than shift?"
	(event anyModifierKeyPressed 
		or: [ (event keyValue between: 32 and: 127) not ])
		ifTrue: [ ^ self ].
	self activateSearchWith: event keyCharacter asString
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

{ #category : 'api - actions' }
SpAbstractEasyPresenter >> rootActionGroup [

	^ contentView rootActionGroup
]

{ #category : 'private' }
SpAbstractEasyPresenter >> selectFirst: aString [

	self subclassResponsibility
]

{ #category : 'api - events' }
SpAbstractEasyPresenter >> whenActivatedDo: aBlock [

	contentView whenActivatedDo: aBlock 
]

{ #category : 'api - events' }
SpAbstractEasyPresenter >> whenSelectionChangedDo: aBlock [
	
	contentView whenSelectionChangedDo: aBlock
]
