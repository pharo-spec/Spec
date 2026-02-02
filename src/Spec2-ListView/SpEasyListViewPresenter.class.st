"
A `SpEasyListViewPresenter` is presenter which handles a basic (""easy"") list displaying information about a domain list. 
For example a list presenter will display the name of a list of contacts. It refines the API of `SpAbstractEasyListViewPresenter` that is shared with `SpEasyComponentListPresenter` (which is a list of presenters) and `SpEasyColumnViewPresenter` (which is a list with multiple columns in a sense). 

### Design point
There are two design points worth notice:

A list presenter has a strategy that encapsulates specific API and action related to selection (how to select, how many items can be selected, currently selected items...). Such strategy is accessed via the `selection` message. It returns an instance of subclasses of `SpAbstractSelectionMode`: `SpMultipleSelectionMode` and `SpSingleSelectionMode`. 
It means many fonctionality related to the selection (selected items, multiple items, ....) are defined in the API of the mode and not of the main class.
 
A list presenter does not offer the possibility to add one item in isolation instead you should use the `items:` setter to set the full list domain object. The responsibility to manage the items displayed by a list presenter is not the one of that list presenter but its users e.g, the presenter you will write and that instantiates and uses the list presenter. This is normal since there is no way that the list presenter could track changes into the domain object representing the list items.

### Defining row presenters
The easy list view presenter implements `rowPresenterClass:`. This message allows users to define their own arbitrary presenters to use with lists. This presenters however require two conditions to be fulfilled: 
- they need to implement `model:`. This is used receive the element to be displayed. This can be achieved by using `SpTModel` presenter, for example)
- they need to implement `listView:`. This is used to set the list that ""owns"" the row element, which can be used to get contextual information.

**Important:** The easiest way to fulfill this conditions is to extent `SpEasyAbstractRowPresenter`. Look at its hierarchy for examples.



"
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
SpEasyListViewPresenter class >> examplePopover [
	"This example show a simple list with all classes, and adds a popover when selection changes."
	| app listView popover |

	app := SpApplication new.
	popover := nil.
	
	(listView := self newApplication: app)
		items: self environment allClasses;
		whenSelectionChangedDo: [ :selection |
			(selection isNotNil and: [ selection selectedItem isNotNil ]) ifTrue: [ 
				popover ifNotNil: [ popover dismiss ].
				(popover := listView newPopover) 
					presenter: (listView newLabel label: selection selectedItem name);
					relativeTo: (listView selectedRowPresenter ifNil: [ listView  ]); 
					doNotTransferFocus;
					popup	] ];
		open
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
	"Answer true if the list has an icon provider (See `SpListViewPresenter>>#displayIcon:`)."

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

{ #category : 'accessing' }
SpEasyListViewPresenter >> itemAt: aNumber [

	^ contentView itemAt: aNumber
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
	 Notice that `aPresenterClass` needs to understand #model: and #listView: 
	 See this class comment to get a full explanation"
	
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

{ #category : 'accessing' }
SpEasyListViewPresenter >> verticalAlignment [

	^ contentView verticalAlignment
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
