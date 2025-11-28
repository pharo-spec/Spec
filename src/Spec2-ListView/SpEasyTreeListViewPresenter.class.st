"
A presenter to display tree of elements.
A `SpEasyTreeListViewPresenter` will display a line with a description of the element (See `SpEasyTreeListViewPresenter>>#display:`, and optionally an icon (See `SpEasyTreeListViewPresenter>>#displayIcon:`).

A `SpEasyTreeListViewPresenter` can be seen as a simplified `SpEasyTreeColumnViewPresenter`.
 
### Defining row presenters
The easy tree view presenter implements `rowPresenterClass:`. This message allows users to define their own arbitrary presenters to use with trees. This presenters however require two conditions to be fulfilled: 
- they need to implement `model:`. This is used receive the element to be displayed. This can be achieved by using `SpTModel` presenter, for example)
- they need to implement `listView:`. This is used to set the list that ""owns"" the row element, which can be used to get contextual information.

**Important:** The easiest way to fulfill this conditions is to extent `SpEasyAbstractRowPresenter`. Look at its hierarchy for examples.

"
Class {
	#name : 'SpEasyTreeListViewPresenter',
	#superclass : 'SpAbstractEasyTreeListViewPresenter',
	#instVars : [
		'#headerPanel',
		'#display => ObservableSlot',
		'#displayIcon => ObservableSlot',
		'#rowPresenterClass'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'accessing' }
SpEasyTreeListViewPresenter class >> defaultRowPresenterClass [

	^ SpEasyListRowPresenter
]

{ #category : 'examples' }
SpEasyTreeListViewPresenter class >> example [
	<sampleInstance>
	
	^ self new
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		display: [ :aClass | aClass name ];
		open
]

{ #category : 'examples' }
SpEasyTreeListViewPresenter class >> examplePopover [
	"This example show a simple list with all classes, and adds a popover when selection changes."
	| app treeView popover |

	app := SpApplication new.
	popover := nil.
	
	(treeView := self newApplication: app)
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		display: [ :aClass | aClass name ];
		whenSelectionChangedDo: [ :selection |
			(selection isNotNil and: [ selection selectedItem isNotNil ]) ifTrue: [ 
				popover ifNotNil: [ popover dismiss ].
				(popover := treeView newPopover) 
					presenter: (treeView newLabel label: selection selectedItem name);
					relativeTo: (treeView selectedRowPresenter ifNil: [ treeView ]); 
					doNotTransferFocus;
					popup	] ];
		open
]

{ #category : 'layout' }
SpEasyTreeListViewPresenter >> defaultLayout [

	^ SpOverlayLayout new
		child: (SpBoxLayout newVertical 
			add: headerPanel expand: false;
			add: contentView;
			yourself);
		addOverlay: searchBox withConstraints: [ :c | c vAlignStart; hAlignEnd ];
		yourself
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> display [
	"Answer the display block that will transform the objects from `SpAbstractListPresenter>>#model` into a
	 displayable string."

	^ display
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> display: aBlock [
	"Set the block that will be applied on each of the list items. 
	 The result of the block will be used to display the item on the screen.
	 `aBlock` receives one argument.
	 Here is the typical example:

	 initializePresenters
   		...
   		fontFamilyList := self newTree.
		fontFamilyList display: [ :fontFamily | fontFamily familyName ]
   		...
	 "

	display := aBlock
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> displayColor: aBlock [
	
	self flag: #TODO
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> displayIcon [
	"Return the block used to return an icon that will be displayed in the list"

	^ displayIcon
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> displayIcon: aBlock [
	"Set a block which takes an item as argument and returns the icon to display in the list. 
	 `aBlock` receives one argument"

	displayIcon := aBlock
]

{ #category : 'private' }
SpEasyTreeListViewPresenter >> displayValueFor: anObject [

	^ self display value: anObject
]

{ #category : 'testing' }
SpEasyTreeListViewPresenter >> hasHeaderTitle [
	"Answer true if the list has a title (See `SpListPresenter>>#headerTitle:`)."

	^ headerPanel isVisible
]

{ #category : 'testing' }
SpEasyTreeListViewPresenter >> hasIcons [
	"Answer true if the list has an icon provider (See `SpEasyTreeListViewPresenter>>#displayIcon:`)."

	^ self displayIcon notNil
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> headerTitle [
	"Answer the header title."

	^ headerPanel label
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> headerTitle: aString [
	"Set the header title."

	headerPanel label:( aString ifNil: [ '' ]). 
	aString isEmptyOrNil 
		ifTrue: [ headerPanel hide ]
		ifFalse: [ headerPanel show ]
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> hideHeaderTitle [

	headerPanel hide
]

{ #category : 'private' }
SpEasyTreeListViewPresenter >> iconFor: anItem [

	^ self displayIcon
		cull: anItem
		cull: self
]

{ #category : 'initialization' }
SpEasyTreeListViewPresenter >> initialize [

	super initialize.
	display := [ :object | object asString ]
]

{ #category : 'initialization' }
SpEasyTreeListViewPresenter >> initializePresenters [

	super initializePresenters.

	headerPanel := self newLabel.
	contentView := self newTreeListView
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
SpEasyTreeListViewPresenter >> registerEvents [

	super registerEvents.
	self whenDisplayChangedDo: [ contentView refresh ]
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> rowPresenterClass [

	^ rowPresenterClass ifNil: [ rowPresenterClass := self class defaultRowPresenterClass ]
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> rowPresenterClass: aPresenterClass [

	rowPresenterClass := aPresenterClass
]

{ #category : 'api - selection' }
SpEasyTreeListViewPresenter >> selectedRowPresenter [

	^ contentView selectedRowPresenter
]

{ #category : 'api - events' }
SpEasyTreeListViewPresenter >> whenDisplayChangedDo: aBlock [
	"Inform when the display block has changed.
 	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #display whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpEasyTreeListViewPresenter >> whenIconsChangedDo: aBlock [
	"Inform when the icons block has changed.
 	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #displayIcon whenChangedDo: aBlock
]
