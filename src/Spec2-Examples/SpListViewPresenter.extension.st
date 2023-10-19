Extension { #name : #SpListViewPresenter }

{ #category : #'*Spec2-Examples' }
SpListViewPresenter class >> example [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClasses;
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		open
]

{ #category : #'*Spec2-Examples' }
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

{ #category : #'*Spec2-Examples' }
SpListViewPresenter class >> exampleWithActions [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClasses;
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		actionsWith: [ :rootGroup | rootGroup
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

{ #category : #'*Spec2-Examples' }
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

{ #category : #'*Spec2-Examples' }
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

{ #category : #'*Spec2-Examples' }
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
