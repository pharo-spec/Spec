Class {
	#name : #SpListViewPresenter,
	#superclass : #SpAbstractListPresenter,
	#classTraits : 'SpTActionContainer classTrait',
	#instVars : [
		'#setupAction',
		'#bindAction',
		'#headerTitle => ObservableSlot'
	],
	#category : #'Spec2-Core-Widgets-ListView'
}

{ #category : #specs }
SpListViewPresenter class >> adapterName [

	^ #ListViewAdapter
]

{ #category : #api }
SpListViewPresenter >> bind: aBlock [

	bindAction := aBlock
]

{ #category : #private }
SpListViewPresenter >> bindAction [

	^ bindAction
]

{ #category : #testing }
SpListViewPresenter >> hasHeaderTitle [
	"Answer true if the list has a title (See `SpListPresenter>>#headerTitle:`)."

	^ headerTitle isEmptyOrNil not
]

{ #category : #api }
SpListViewPresenter >> headerTitle [
	"Answer the header title."

	^ headerTitle
]

{ #category : #api }
SpListViewPresenter >> headerTitle: aString [
	"Set the header title."

	headerTitle := aString
]

{ #category : #initialization }
SpListViewPresenter >> initialize [
	
	super initialize.
	self registerActions.	
	self initializeItemFactory.

]

{ #category : #initialization }
SpListViewPresenter >> initializeItemFactory [
	"Just set up the defaults (to ensure we have a working list at any moment)"
	
	self setup: [ :aPresenter | aPresenter newLabel ].
	self bind: [ :aPresenter :anObject | aPresenter label: anObject asString ]
]

{ #category : #initialization }
SpListViewPresenter >> registerActions [

	self addActionWith: [ :action | action 
		beOnlyShortcut;
		shortcut: $t ctrl unix | $t ctrl win | $t command mac;
		action: [ self showContextMenu ] ]
]

{ #category : #initialization }
SpListViewPresenter >> registerEvents [

	super registerEvents.

	self 
		property: #headerTitle 
		whenChangedDo: [ 
			self withAdapterDo: [ :anAdapter | anAdapter refreshList ] ]
]

{ #category : #api }
SpListViewPresenter >> setup: aBlock [

	setupAction := aBlock
]

{ #category : #private }
SpListViewPresenter >> setupAction [

	^ setupAction
]

{ #category : #api }
SpListViewPresenter >> showContextMenu [ 
	"If the presenter is displayed, shows the associated context menu"

	self withAdapterDo: [ :anAdapter | anAdapter showContextMenu ]
]

{ #category : #'api - events' }
SpListViewPresenter >> whenDisplayChangedDo: aBlock [
	"Inform when the display block has changed.
 	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #display whenChangedDo: aBlock
]

{ #category : #'api - events' }
SpListViewPresenter >> whenIconsChangedDo: aBlock [
	"Inform when the icons block has changed.
 	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #icon whenChangedDo: aBlock
]
