Class {
	#name : 'SpEasyListViewPresenter',
	#superclass : 'SpPresenter',
	#traits : 'SpTSearchable',
	#classTraits : 'SpTSearchable classTrait',
	#instVars : [
		'#display => ObservableSlot',
		'#displayIcon => ObservableSlot',
		'#searchInput',
		'#listView',
		'#headerPanel',
		'#lastSelectedRow => WeakSlot'
	],
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
}

{ #category : 'specs' }
SpEasyListViewPresenter class >> adapterName [

	^ #EasyListViewAdapter
]

{ #category : 'examples' }
SpEasyListViewPresenter class >> example [
	"This example show a simple list with all classes, using all the default settings."

	^ self new
		"application: (SpApplication new useBackend: #Gtk);"
		items: self environment allClasses;
		open;
		yourself
]

{ #category : 'examples' }
SpEasyListViewPresenter class >> exampleMultipleSelection [

	^ self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClasses;
		beMultipleSelection;
		open;
		yourself
]

{ #category : 'examples' }
SpEasyListViewPresenter class >> exampleWithHeaderTitle [

	^ self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClasses;
		headerTitle: 'Title';
		open;
		yourself
]

{ #category : 'examples' }
SpEasyListViewPresenter class >> exampleWithIcons [
	"This example show a simple list with icons."

	^ self new
		application: (SpApplication new useBackend: #Gtk);
		displayIcon: [ :e | self iconNamed: #forwardIcon ];
		items: (1 to: 10) asArray;
		open;
		yourself
]

{ #category : 'api - actions' }
SpEasyListViewPresenter >> actionGroup [

	^ listView actionGroup
]

{ #category : 'api - actions' }
SpEasyListViewPresenter >> actionGroup: aSpCommandGroup [

	listView actionGroup: aSpCommandGroup
]

{ #category : 'api' }
SpEasyListViewPresenter >> activateOnDoubleClick [

	listView activateOnDoubleClick
]

{ #category : 'api' }
SpEasyListViewPresenter >> activateOnSingleClick [

	listView activateOnSingleClick
]

{ #category : 'private' }
SpEasyListViewPresenter >> activateSearchWith: aString [

	lastSelectedRow := listView selectedItem.

	searchInput text: aString.
	searchInput show.
	searchInput takeKeyboardFocus.
	searchInput unselectAll.
	searchInput cursorPositionIndex: aString size
]

{ #category : 'api - actions' }
SpEasyListViewPresenter >> addAction: aSpCommand [

	listView addAction: aSpCommand
]

{ #category : 'api' }
SpEasyListViewPresenter >> addScrollBarStyle: aStyle [

	listView addScrollBarStyle: aStyle
]

{ #category : 'api' }
SpEasyListViewPresenter >> beMultipleSelection [

	listView beMultipleSelection
]

{ #category : 'api' }
SpEasyListViewPresenter >> beSingleSelection [

	listView beSingleSelection
]

{ #category : 'initialization' }
SpEasyListViewPresenter >> connectPresenters [

	searchInput 
		addAction: (SpAction
			newShortcut: Character escape asKeyCombination 
			action: [ self deactivateSearch: false ]);
		addAction: (SpAction
			newShortcut: Character cr asKeyCombination 
			action: [ self deactivateSearch: true ]);
		whenTextChangedDo: [ :aString | self selectFirst: aString ].
	
	listView eventHandler 
		whenKeyDownDo: [ :event | self maybeActivateSearchOn: event ];
		whenFocusReceivedDo: [ :event | searchInput hide ]
]

{ #category : 'private' }
SpEasyListViewPresenter >> deactivateSearch: acceptSelection [
	| currentSelection |

	currentSelection := listView selectedItem.
	searchInput hide.
	listView selectItem: (acceptSelection 
		ifTrue: [ currentSelection ]
		ifFalse: [ lastSelectedRow ]).
	listView takeKeyboardFocus
]

{ #category : 'transmission' }
SpEasyListViewPresenter >> defaultInputPort [

	^ self inputItemsPort
]

{ #category : 'layout' }
SpEasyListViewPresenter >> defaultLayout [

	^ SpOverlayLayout new
		child: (SpBoxLayout newVertical 
			add: headerPanel expand: false;
			add: listView;
			yourself);
		addOverlay: searchInput withConstraints: [ :c | c vAlignStart; hAlignEnd ];
		yourself
]

{ #category : 'transmission' }
SpEasyListViewPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : 'api' }
SpEasyListViewPresenter >> disable [

	self enabled: false
]

{ #category : 'api' }
SpEasyListViewPresenter >> display [
	"Answer the display block that will transform the objects from `SpAbstractListPresenter>>#model` into a
	 displayable string."

	^ display
]

{ #category : 'api' }
SpEasyListViewPresenter >> display: aBlock [
	"Set the block that will be applied on each of the list items. 
	 The result of the block will be used to display the item on the screen.
	 `aBlock` receives one argument.
	 Here is the typical example:

	 initializePresenters
   		...
   		fontFamilyList := self newList.
		fontFamilyList display: [ :fontFamily | fontFamily familyName ]
   		...
	 "

	display := aBlock
]

{ #category : 'api' }
SpEasyListViewPresenter >> displayIcon [
	"Return the block used to return an icon that will be displayed in the list"

	^ displayIcon
]

{ #category : 'api' }
SpEasyListViewPresenter >> displayIcon: aBlock [
	"Set a block which takes an item as argument and returns the icon to display in the list. 
	 `aBlock` receives one argument"

	displayIcon := aBlock
]

{ #category : 'private' }
SpEasyListViewPresenter >> displayValueFor: anObject [

	^ self display value: anObject
]

{ #category : 'api' }
SpEasyListViewPresenter >> enable [

	self enabled: true
]

{ #category : 'private' }
SpEasyListViewPresenter >> findFirst: aString [
	| items |

	items := listView items.
	items isEmptyOrNil ifTrue: [ ^ 0 ].
	
	(listView selection selectedIndex max: 1) to: items size do: [ :index | 
	 	(self
			performSearch: (items at: index)
			matching: aString)
			ifTrue: [ ^ index ] ].
		
	^ 0
]

{ #category : 'testing' }
SpEasyListViewPresenter >> hasHeaderTitle [
	"Answer true if the list has a title (See `SpListPresenter>>#headerTitle:`)."

	^ headerPanel isVisible
]

{ #category : 'testing' }
SpEasyListViewPresenter >> hasIcons [
	"Answer true if the list has an icon provider (See `SpListPresenter>>#icons:`)."

	^ self displayIcon notNil
]

{ #category : 'api' }
SpEasyListViewPresenter >> headerTitle [
	"Answer the header title."

	^ headerPanel label
]

{ #category : 'api' }
SpEasyListViewPresenter >> headerTitle: aString [
	"Set the header title."

	headerPanel label:( aString ifNil: [ '' ]). 
	aString isEmptyOrNil 
		ifTrue: [ headerPanel hide ]
		ifFalse: [ headerPanel show ]
]

{ #category : 'api' }
SpEasyListViewPresenter >> hideHeaderTitle [

	headerPanel hide
]

{ #category : 'private' }
SpEasyListViewPresenter >> iconFor: anItem [

	^ self displayIcon
		cull: anItem
		cull: self
]

{ #category : 'initialization' }
SpEasyListViewPresenter >> initialize [

	super initialize.
	self initializeTSearchable.
	display := [ :object | object asString ]
]

{ #category : 'initialization' }
SpEasyListViewPresenter >> initializePresenters [

	headerPanel := self newLabel.
	listView := self newListView
		setup: [ :aPresenter | 
			(aPresenter instantiate: SpEasyListRowPresenter)
				listView: self;
				yourself ];
		bind: [ :aPresenter :anObject | 
			aPresenter model: anObject ];
		yourself.
	searchInput := self newTextInput.
	
	headerPanel hide.
	searchInput hide
]

{ #category : 'transmission' }
SpEasyListViewPresenter >> inputItemsPort [

	^ (SpListItemsPort newPresenter: self)
		delegateTo: [ listView ];
		yourself	
]

{ #category : 'api' }
SpEasyListViewPresenter >> items [

	^ listView items
]

{ #category : 'api' }
SpEasyListViewPresenter >> items: anOrderedCollection [

	listView items: anOrderedCollection
]

{ #category : 'private' }
SpEasyListViewPresenter >> maybeActivateSearchOn: event [
		
	self isSearchEnabled ifFalse: [ ^ self ].
	"any modifier other than shift?"
	(event anyModifierKeyPressed 
		or: [ (event keyValue between: 32 and: 127) not ])
		ifTrue: [ ^ self ].
	self activateSearchWith: event keyCharacter asString
]

{ #category : 'api' }
SpEasyListViewPresenter >> model [

	^ listView model
]

{ #category : 'transmission' }
SpEasyListViewPresenter >> outputActivationPort [
	
	^ (SpActivationPort newPresenter: self)
		delegateTo: [ listView ];
		yourself
]

{ #category : 'transmission' }
SpEasyListViewPresenter >> outputSelectionPort [
	
	^ (SpSelectionPort newPresenter: self)
		delegateTo: [ listView ];
		yourself
]

{ #category : 'initialization' }
SpEasyListViewPresenter >> registerEvents [

	super registerEvents.

	self whenDisplayChangedDo: [ listView refresh ]
]

{ #category : 'api' }
SpEasyListViewPresenter >> removeScrollBarStyle: aStyle [

	^ listView removeScrollBarStyle: aStyle
]

{ #category : 'api' }
SpEasyListViewPresenter >> scrollBarStyles [

	^ listView scrollBarStyles
]

{ #category : 'private' }
SpEasyListViewPresenter >> selectFirst: aString [
	| index |

	index := self findFirst: aString.
	index = 0 ifTrue: [ ^ self ].
	
	listView selectIndex: index scrollToSelection: true
]

{ #category : 'api - selection' }
SpEasyListViewPresenter >> selectedItem [
	
	^ listView selectedItem
]

{ #category : 'api' }
SpEasyListViewPresenter >> updateItemsKeepingSelection: aCollection [
	
	listView updateItemsKeepingSelection: aCollection
]

{ #category : 'api - events' }
SpEasyListViewPresenter >> whenDisplayChangedDo: aBlock [
	"Inform when the display block has changed.
 	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #display whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpEasyListViewPresenter >> whenIconsChangedDo: aBlock [
	"Inform when the icons block has changed.
 	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #displayIcon whenChangedDo: aBlock
]

{ #category : 'api' }
SpEasyListViewPresenter >> withScrollBars [

	listView withScrollBars
]

{ #category : 'api' }
SpEasyListViewPresenter >> withoutScrollBars [

	listView withoutScrollBars
]
