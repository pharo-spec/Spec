Class {
	#name : 'SpListViewPresenter',
	#superclass : 'SpAbstractListPresenter',
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
SpListViewPresenter class >> adapterName [

	^ #ListViewAdapter
]

{ #category : 'examples' }
SpListViewPresenter class >> example [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClasses;
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		open
]

{ #category : 'examples' }
SpListViewPresenter class >> exampleActivateOnDoubleClick [
	"This example show the simples list view you can make: A list with a label"

	self new
		application: (SpApplication new useBackend: #Gtk);
		isActiveOnDoubleClick;
		items: self environment allClasses;
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		whenActivatedDo: [ 'OK' crTrace ];
		open
]

{ #category : 'examples' }
SpListViewPresenter class >> exampleReplaceItems [
	"This example shows how to replace dynamically the list of elements."
	| presenter listView button items |

	items := #().

	presenter := SpPresenter newApplication: (SpApplication new "useBackend: #Gtk").
	presenter layout: (SpBoxLayout newVertical
		add: (listView := presenter newListView);
		add: (button := presenter newButton) expand: false;
		yourself).
	
	listView 
		items: #();
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :aClass | aPresenter label: aClass name ].

	button 
		label: 'Add';
		action: [ listView items: (items := items copyWith: self environment allClasses atRandom) ].
		
	^ presenter open
]

{ #category : 'examples' }
SpListViewPresenter class >> exampleWithActions [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClasses;
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
SpListViewPresenter class >> exampleWithIcons [
	"This example shows how to construct a list with icons. 
	 It shows also the fact you can put any presenter inside, giving a huge power 
	 to your lists."

	^ self new
		"application: (SpApplication new useBackend: #Gtk);"
		items: self environment allClasses;
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
SpListViewPresenter class >> exampleWithIconsAndMorph [
	"This example shows how to construct a list with icons. 
	 It shows also the fact you can put any presenter inside, giving a huge power 
	 to your lists."

	^ self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClasses;
		setup: [ :aPresenter |
			| presenter morph |
			(presenter := aPresenter newPresenter)
				layout: (SpBoxLayout newHorizontal
					spacing: 5;
					add: presenter newImage expand: false;
					add: presenter newLabel;
					add: (presenter newMorph 
						morph: ((morph := SimpleButtonMorph new)
							color: Color blue;
							target: [ 
								self inform: 'Clicked: ', morph label ];
							actionSelector: #value;
							yourself);
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

{ #category : 'examples' }
SpListViewPresenter class >> exampleWithIconsAndSelectedItem [
	"This example shows how to construct a list with icons. 
	 It shows also the fact you can put any presenter inside, giving a huge power 
	 to your lists."

	^ self new
		"application: (SpApplication new useBackend: #Gtk);"
		items: self environment allClasses;
		selectItem: Object scrollToSelection: true;
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
SpListViewPresenter class >> exampleWithIconsMultipleSelection [
	"This example shows how to construct a list with multiple selection available. 
	 It shows also the fact you can put any presenter inside, giving a huge power 
	 to your lists."

	^ self new
		"application: (SpApplication new useBackend: #Gtk);"
		beMultipleSelection;
		items: self environment allClasses;
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

{ #category : 'api' }
SpListViewPresenter >> bind: aBlock [

	bindAction := aBlock
]

{ #category : 'private' }
SpListViewPresenter >> bindAction [

	^ bindAction
]

{ #category : 'testing' }
SpListViewPresenter >> hasHeaderTitle [
	"Answer true if the list has a title (See `SpListPresenter>>#headerTitle:`)."

	^ headerTitle isEmptyOrNil not
]

{ #category : 'api' }
SpListViewPresenter >> headerTitle [
	"Answer the header title."

	^ headerTitle
]

{ #category : 'api' }
SpListViewPresenter >> headerTitle: aString [
	"Set the header title."

	headerTitle := aString
]

{ #category : 'initialization' }
SpListViewPresenter >> initialize [
	
	super initialize.
	self initializeItemFactory
]

{ #category : 'initialization' }
SpListViewPresenter >> initializeItemFactory [
	"Just set up the defaults (to ensure we have a working list at any moment)"
	
	self setup: [ :aPresenter | aPresenter newLabel ].
	self bind: [ :aPresenter :anObject | aPresenter label: anObject asString ]
]

{ #category : 'initialization' }
SpListViewPresenter >> registerEvents [

	super registerEvents.
	self 
		property: #headerTitle 
		whenChangedDo: [ 
			self withAdapterDo: [ :anAdapter | anAdapter refreshList ] ]
]

{ #category : 'api' }
SpListViewPresenter >> setup: aBlock [

	setupAction := aBlock
]

{ #category : 'private' }
SpListViewPresenter >> setupAction [

	^ setupAction
]
