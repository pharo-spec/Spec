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
		items: self environment allClasses;
		open;
		yourself
]

{ #category : 'examples' }
SpEasyListViewPresenter class >> exampleDragAndDrop [
	| list1 list2 |

	(list1 := self new)
		items: #( 'abc' 'def' 'xyz' );
		dragEnabled: true;
		whenDragStartDo: [ :ann | 
			ann transfer description: ('Passing "{1}" element' format: ann transfer passenger) ].
		
	(list2 := self new)
		dropEnabled: true;
		wantsDrop: [ :transfer | transfer passenger allSatisfy: #isString ];
		acceptDrop: [ :transfer | list2 items: (list2 items, transfer passenger) ].
				
	(SpPresenter newApplication: SpApplication new)
		layout: (SpBoxLayout newLeftToRight
			add: list1;
			add: list2;
			yourself);
		open
]

{ #category : 'examples' }
SpEasyListViewPresenter class >> exampleMultipleSelection [

	^ self new
		items: self environment allClasses;
		beMultipleSelection;
		open;
		yourself
]

{ #category : 'examples' }
SpEasyListViewPresenter class >> exampleWithHeaderTitle [

	^ self new
		items: self environment allClasses;
		headerTitle: 'Title';
		open;
		yourself
]

{ #category : 'examples' }
SpEasyListViewPresenter class >> exampleWithIcons [
	"This example show a simple list with icons."

	^ self new
		displayIcon: [ :e | self iconNamed: #forwardIcon ];
		items: (1 to: 10) asArray;
		open;
		yourself
]

{ #category : 'simulation' }
SpEasyListViewPresenter >> clickAtIndex: aNumber [

	contentView clickAtIndex: aNumber
]

{ #category : 'initialization' }
SpEasyListViewPresenter >> connectPresenters [

	super connectPresenters
]

{ #category : 'api' }
SpEasyListViewPresenter >> contextMenu [
 
	^ contentView contextMenu
]

{ #category : 'api' }
SpEasyListViewPresenter >> contextMenu: aBlock [
 
	contentView contextMenu: aBlock
]

{ #category : 'layout' }
SpEasyListViewPresenter >> defaultLayout [

	^ SpOverlayLayout new
		child: (SpBoxLayout newTopToBottom 
			add: headerPanel expand: false;
			add: contentView;
			yourself);
		addOverlay: searchBox withConstraints: [ :c | c vAlignStart; hAlignEnd ];
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

{ #category : 'simulation' }
SpEasyListViewPresenter >> doubleClickAtIndex: aNumber [

	contentView doubleClickAtIndex: aNumber
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
SpEasyListViewPresenter >> rowPresenterClass: aPresenterClass [
	"Presenter to be used for the row. 
	 Anything defined in #display: and #displayIcon: will be ignored.
	 Notice that `aPresenterClass` needs to understand #model:"
	
	rowPresenterClass := aPresenterClass
]

{ #category : 'api - selection' }
SpEasyListViewPresenter >> selectAll [

	contentView selectAll
]

{ #category : 'api - selection' }
SpEasyListViewPresenter >> selectIndex: aNumber scrollToSelection: aBoolean [ 
	
	contentView selectIndex: aNumber scrollToSelection: aBoolean
]

{ #category : 'api' }
SpEasyListViewPresenter >> sortingBlock: aBlock [

	contentView sortingBlock: aBlock
]

{ #category : 'api - selection' }
SpEasyListViewPresenter >> unselectAll [

	contentView unselectAll
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

{ #category : 'api - events' }
SpEasyListViewPresenter >> whenMenuChangedDo: aBlock [

	contentView whenMenuChangedDo: aBlock
]

{ #category : 'api - events' }
SpEasyListViewPresenter >> whenSortingBlockChangedDo: aBlock [

	contentView whenSortingBlockChangedDo: aBlock
]
