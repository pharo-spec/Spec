Class {
	#name : 'SpTreeListViewPresenter',
	#superclass : 'SpAbstractTreePresenter',
	#classTraits : 'SpTActionContainer classTrait',
	#instVars : [
		'#setupAction',
		'#bindAction',
		'#headerTitle => ObservableSlot'
	],
	#category : 'Spec2-ListView-Widget',
	#package : 'Spec2-ListView',
	#tag : 'Widget'
}

{ #category : 'specs' }
SpTreeListViewPresenter class >> adapterName [

	^ #TreeListViewAdapter
]

{ #category : 'examples' }
SpTreeListViewPresenter class >> example [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: (SpApplication new useBackend: #Gtk);
		items: { Object };
		children: [ :aClass | aClass subclasses ];
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		open
]

{ #category : 'examples' }
SpTreeListViewPresenter class >> exampleActivateOnDoubleClick [
	"This example show the simples list view you can make: A list with a label"
	| presenter |

	(presenter := self new)
		application: (SpApplication new useBackend: #Gtk);
		activateOnDoubleClick;
		items: { Object };
		children: [ :aClass | aClass subclasses ];
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		whenActivatedDo: [ presenter selectedItem crTrace ];
		open
]

{ #category : 'examples' }
SpTreeListViewPresenter class >> exampleRefreshList [
	"this example just shows how the tree is refreshed when changing the model"
	| presenter button tree |
	
	presenter := SpPresenter new.
	presenter application: (SpApplication new useBackend: #Gtk).

	presenter layout: (SpBoxLayout newHorizontal
		add: (button := presenter newButton);
		add: (tree := presenter newTreeListView);
		yourself).
		
	tree 
		roots: #();
		children: [ :aClass | aClass subclasses ].	
		
	button 
		label: 'Click'; 
		action: [ 
			| allClasses roots |
			allClasses := Smalltalk allClasses.
			roots := (1 to: 10) collect: [ :index | allClasses atRandom ]. 
			tree roots: roots ].

	presenter open
]

{ #category : 'examples' }
SpTreeListViewPresenter class >> exampleWithActions [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: (SpApplication new useBackend: #Gtk);
		items: { Object };
		children: [ :aClass | aClass subclasses ];
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		withRootActionGroupDo: [ :rootGroup | rootGroup
			addGroupWith: [ :aGroup | aGroup 
				name: 'Group 1';
				beDisplayedAsGroup;
				addActionWith: [ :act | act 
					name: 'Test 1'; 
					shortcut: $a ctrl;
					action: [ 'Test 1.1' crTrace ] ];
				addActionWith: [ :act | act 
					name: 'Test 2'; 
					action: [ 'Test 1.2' crTrace ] ] ];
			addGroupWith: [ :subGroup1 | subGroup1 
				name: 'Group 2';
				addActionWith: [ :act | act 
					name: 'Test 1';
					shortcut: $y ctrl;  
					action: [ 'Test 2.1' crTrace ]; 
					actionEnabled: [ false ] ];
				addActionWith: [ :act | act 
					name: 'Test 2';
					action: [ 'Test 2.2' crTrace ] ] ];
			addActionWith: [ :act | act 
				name: 'Test 3'; 
				shortcut: $a ctrl; 
				action: [ 'Test 3' crTrace ] ];
			addActionWith: [ :act | act 
				name: 'Test 4'; 
				shortcut: Character escape asKeyCombination; 
				action: [ 'Test 4' crTrace ] ] ];
		open
]

{ #category : 'examples' }
SpTreeListViewPresenter class >> exampleWithIcons [
	"This example shows how to construct a list with icons. 
	 It shows also the fact you can put any presenter inside, giving a huge power 
	 to your lists."

	^ self new
		application: (SpApplication new useBackend: #Gtk);
		items: { Object };
		children: [ :aClass | aClass subclasses ];
		setup: [ :aPresenter |
			| presenter |
			(presenter := aPresenter newPresenter)
				layout: (SpBoxLayout newHorizontal
					spacing: 5;
					add: presenter newImage expand: false;
					add: presenter newLabel;
					yourself);
				yourself ];
		bind: [ :aPresenter :aClass | | icon image label |
			icon := Smalltalk ui icons iconNamed: aClass systemIconName.
			image := aPresenter layout children first.
			image image: icon.
			label := aPresenter layout children second.
			label label: aClass name ];
		open
]

{ #category : 'examples' }
SpTreeListViewPresenter class >> exampleWithIconsAndMorph [
	"This example shows how to construct a list with icons. 
	 It shows also the fact you can put any presenter inside, giving a huge power 
	 to your lists."

	^ self new
		application: (SpApplication new useBackend: #Gtk);
		items: { Object };
		children: [ :aClass | aClass subclasses ];
		setup: [ :aPresenter |
			| presenter |
			(presenter := aPresenter newPresenter)
				layout: (SpBoxLayout newHorizontal
					spacing: 5;
					add: presenter newImage expand: false;
					add: presenter newLabel;
					add: (presenter newMorph 
						morph: SimpleButtonMorph new;
						yourself);
					yourself);
				yourself ];
		bind: [ :aPresenter :aClass | | icon image label morph |
			icon := Smalltalk ui icons iconNamed: aClass systemIconName.
			image := aPresenter layout children first.
			image image: icon.
			label := aPresenter layout children second.
			label label: aClass name.
			morph := aPresenter layout children third.
			morph morph label: aClass name ];
		open
]

{ #category : 'api' }
SpTreeListViewPresenter >> alternateRowsColor [
	"Will alternate Rows color for a better reading: one row lighter, the next row darker. 
	 NOTE: Behavior in different backends may be slightly different."

	self withAdapterPerformOrDefer: [ :anAdapter | 
		anAdapter alternateRowsColor ]
]

{ #category : 'api' }
SpTreeListViewPresenter >> bind: aBlock [

	bindAction := aBlock
]

{ #category : 'private' }
SpTreeListViewPresenter >> bindAction [

	^ bindAction
]

{ #category : 'testing' }
SpTreeListViewPresenter >> hasHeaderTitle [
	"Answer true if the list has a title (See `SpListPresenter>>#headerTitle:`)."

	^ headerTitle isEmptyOrNil not
]

{ #category : 'api' }
SpTreeListViewPresenter >> headerTitle [
	"Answer the header title."

	^ headerTitle
]

{ #category : 'api' }
SpTreeListViewPresenter >> headerTitle: aString [
	"Set the header title."

	headerTitle := aString
]

{ #category : 'initialization' }
SpTreeListViewPresenter >> initialize [
	
	super initialize.

	childrenBlock := [ :item | #() ].
	
	self beSingleSelection.
	self activateOnDoubleClick.

	self registerActions.	
	self initializeItemFactory
]

{ #category : 'initialization' }
SpTreeListViewPresenter >> initializeItemFactory [
	"Just set up the defaults (to ensure we have a working list at any moment)"
	
	self setup: [ :aPresenter | aPresenter newLabel ].
	self bind: [ :aPresenter :anObject | aPresenter label: anObject asString ]
]

{ #category : 'initialization' }
SpTreeListViewPresenter >> registerEvents [

	super registerEvents.
	self 
		property: #headerTitle 
		whenChangedDo: [ 
			self withAdapterDo: [ :anAdapter | anAdapter refreshList ] ]
]

{ #category : 'api' }
SpTreeListViewPresenter >> setup: aBlock [

	setupAction := aBlock
]

{ #category : 'private' }
SpTreeListViewPresenter >> setupAction [

	^ setupAction
]
