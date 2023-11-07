Extension { #name : 'SpDropDownPresenter' }

{ #category : '*Spec2-Examples' }
SpDropDownPresenter class >> example [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClasses;
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		display: [ :aClass | aClass name ];
		open
]

{ #category : '*Spec2-Examples' }
SpDropDownPresenter class >> exampleWithIcons [
	"This example shows how to construct a list with icons. 
	 It shows also the fact you can put any presenter inside, giving a huge power 
	 to your lists."

	^ self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClasses;
		setup: [ :aPresenter |
			| presenter |
			(presenter := aPresenter newPresenter)
				layout: (SpBoxLayout newHorizontal
					"spacing: 5;"
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

{ #category : '*Spec2-Examples' }
SpDropDownPresenter class >> exampleWithSelectedItem [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClassesAndTraits;
		setup: [ :aPresenter | aPresenter newLabel ];
		bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		display: [ :aClass | aClass name ];
		selectItem: Object;
		whenSelectionChangedDo: [ :aSelection | aSelection selectedItem crTrace ];
		open
]
