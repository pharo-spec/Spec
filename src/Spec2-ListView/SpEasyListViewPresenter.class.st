Class {
	#name : 'SpEasyListViewPresenter',
	#superclass : 'SpAbstractEasyListViewPresenter',
	#instVars : [
		'#display => ObservableSlot',
		'#displayIcon => ObservableSlot',
		'#headerPanel',
		'#rowPresenterClass'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'accessing' }
SpEasyListViewPresenter class >> defaultRowPresenterClass [

	^ SpEasyListRowPresenter
]

{ #category : 'examples' }
SpEasyListViewPresenter class >> example [
	"This example show a simple list with all classes, using all the default settings."

	^ self new
		application: (SpApplication new useBackend: #Gtk);
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

{ #category : 'initialization' }
SpEasyListViewPresenter >> connectPresenters [

	super connectPresenters
]

{ #category : 'api' }
SpEasyListViewPresenter >> contextMenu: aBlock [
 
	self flag: #TODO. "Ignored, as this should be deprecated"
	
]

{ #category : 'layout' }
SpEasyListViewPresenter >> defaultLayout [

	^ SpOverlayLayout new
		child: (SpBoxLayout newVertical 
			add: headerPanel expand: false;
			add: contentView;
			yourself);
		addOverlay: searchInput withConstraints: [ :c | c vAlignStart; hAlignEnd ];
		yourself
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
	display := [ :anObject | anObject asString ]
]

{ #category : 'initialization' }
SpEasyListViewPresenter >> initializePresenters [

	super initializePresenters.

	headerPanel := self newLabel.
	contentView := self newListView
		setup: [ :aPresenter | 
			(aPresenter instantiate: self rowPresenterClass)
				listView: self;
				yourself ];
		bind: [ :aPresenter :anObject | 
			aPresenter model: anObject ];
		yourself.
		
	headerPanel hide
]

{ #category : 'initialization' }
SpEasyListViewPresenter >> registerEvents [

	super registerEvents.
	self whenDisplayChangedDo: [ contentView refresh ]
]

{ #category : 'api' }
SpEasyListViewPresenter >> rowPresenterClass [
	
	^ rowPresenterClass ifNil: [ rowPresenterClass := self class defaultRowPresenterClass ]
]

{ #category : 'api' }
SpEasyListViewPresenter >> rowPresenterClass: aClass [
	
	rowPresenterClass := aClass
]

{ #category : 'api' }
SpEasyListViewPresenter >> updateItemsKeepingSelection: aCollection [
	
	contentView updateItemsKeepingSelection: aCollection
]

{ #category : 'private' }
SpEasyListViewPresenter >> whenDisplayChangedDo: aBlock [
	"Inform when the display block has changed.
 	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #display whenChangedDo: aBlock
]

{ #category : 'private' }
SpEasyListViewPresenter >> whenIconsChangedDo: aBlock [
	"Inform when the icons block has changed.
 	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #displayIcon whenChangedDo: aBlock
]
