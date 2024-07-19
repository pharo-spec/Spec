Class {
	#name : 'SpEasyTreeListViewPresenter',
	#superclass : 'SpAbstractEasyTreeListViewPresenter',
	#instVars : [
		'#headerPanel',
		'#display => ObservableSlot',
		'#displayIcon => ObservableSlot'
	],
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
}

{ #category : 'api' }
SpEasyTreeListViewPresenter >> children: aBlock [

	contentView children: aBlock
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> contextMenu: aBlock [ 
	
	self flag: #TODO
]

{ #category : 'layout' }
SpEasyTreeListViewPresenter >> defaultLayout [

	^ SpOverlayLayout new
		child: (SpBoxLayout newVertical 
			add: headerPanel expand: false;
			add: contentView;
			yourself);
		addOverlay: searchInput withConstraints: [ :c | c vAlignStart; hAlignEnd ];
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
	"Answer true if the list has an icon provider (See `SpListPresenter>>#icons:`)."

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
			(aPresenter instantiate: SpEasyListRowPresenter)
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
