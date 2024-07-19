Class {
	#name : 'SpTreeColumnViewPresenter',
	#superclass : 'SpAbstractTreePresenter',
	#instVars : [
		'#columns => ObservableSlot',
		'#isResizable => ObservableSlot',
		'#showColumnHeaders => ObservableSlot'
	],
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
}

{ #category : 'specs' }
SpTreeColumnViewPresenter class >> adapterName [

	^ #TreeColumnViewAdapter
]

{ #category : 'examples' }
SpTreeColumnViewPresenter class >> example [
	
	^ self new
		application: (SpApplication new useBackend: #Gtk);
		addColumnTitle: 'Class' 
			setup: [ :aPresenter | aPresenter newLabel ] 
			bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		addColumnTitle: 'Lines of code' 
			setup: [ :aPresenter | aPresenter newLabel ] 
			bind: [ :aPresenter :aClass | aPresenter label: aClass linesOfCode asString ];
		items: { Object };
		children: [ :aClass | aClass subclasses ];
		open
]

{ #category : 'examples' }
SpTreeColumnViewPresenter class >> exampleActivateOnDoubleClick [

	^ self new
		application: (SpApplication new useBackend: #Gtk);
	 	 activateOnDoubleClick;
	  	addColumnTitle: 'Class'
	  		setup: [ :aPresenter | aPresenter newLabel ]
	  		bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
	  	addColumnTitle: 'Lines of code'
	  		setup: [ :aPresenter | aPresenter newLabel ]
	  		bind: [ :aPresenter :aClass | aPresenter label: aClass linesOfCode asString ];
	  	items: { Object };
	  	children: [ :aClass | aClass subclasses ];
	  	whenActivatedDo: [ :selection | selection selectedItem crTrace ];
	  	open
]

{ #category : 'examples' }
SpTreeColumnViewPresenter class >> exampleRefreshList [
	"this example just shows how the tree is refreshed when changing the model"
	| presenter button tree |

	presenter := SpPresenter new.
	presenter application: (SpApplication new useBackend: #Gtk).

	presenter layout: (SpBoxLayout newHorizontal
		add: (button := presenter newButton);
		add: (tree := presenter newTreeColumnView);
		yourself).
		
	tree 
		roots: #();
		children: [ :aClass | aClass subclasses ].	
		
	tree 		
		addColumnTitle: 'Class' 
			setup: [ :aPresenter | aPresenter newLabel ] 
			bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		addColumnTitle: 'Lines of code' 
				setup: [ :aPresenter | aPresenter newLabel ] 
				bind: [ :aPresenter :aClass | aPresenter label: aClass linesOfCode asString ].
		
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
SpTreeColumnViewPresenter class >> exampleResizableColumns [
	
	^ self new
		application: (SpApplication new useBackend: #Gtk);
		beResizable;
	  	items: { Object };
	  	children: [ :aClass | aClass subclasses ];
		addColumnTitle: 'Class' 
			setup: [ :aPresenter | aPresenter newLabel ] 
			bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		addColumnTitle: 'Lines of code' 
			setup: [ :aPresenter | aPresenter newLabel ] 
			bind: [ :aPresenter :aClass | aPresenter label: aClass linesOfCode asString ];		
		open
]

{ #category : 'examples' }
SpTreeColumnViewPresenter class >> exampleWithIcons [
	
	^ self new
		application: (SpApplication new useBackend: #Gtk);
		addColumnTitle: 'Class' 
			setup: [ :aPresenter |
				| presenter |
				(presenter := aPresenter newPresenter)
					layout: (SpBoxLayout newHorizontal
						spacing: 5;
						add: presenter newImage expand: false;
						add: presenter newLabel;
						yourself);
					yourself ]
			bind: [ :aPresenter :aClass | | icon image label |
				icon := Smalltalk ui icons iconNamed: aClass systemIconName.
				image := aPresenter layout children first.
				image image: icon.
				label := aPresenter layout children second.
				label label: aClass name ];
	  	addColumnTitle: 'Lines of code'
	  		setup: [ :aPresenter | aPresenter newLabel ]
	  		bind: [ :aPresenter :aClass | aPresenter label: aClass linesOfCode asString ];
	  	items: { Object };
	  	children: [ :aClass | aClass subclasses ];
		open
]

{ #category : 'api' }
SpTreeColumnViewPresenter >> addColumn: aColumn [
	"Add a column to the table. A column should be an instance of `SpTableColumn`"

	columns := columns copyWith: aColumn
]

{ #category : 'api' }
SpTreeColumnViewPresenter >> addColumnTitle: aTitle setup: setupBlock bind: bindBlock [

	^ self addColumn: (SpColumnViewColumn 
		newTitle: aTitle
		setup: setupBlock
		bind: bindBlock)
]

{ #category : 'api' }
SpTreeColumnViewPresenter >> addColumns: aCollection [
	"Add a list of columns.
	 `aCollection` is a list of instances of `SpTableColumn`"

	aCollection do: [ :each | self addColumn: each ]
]

{ #category : 'api' }
SpTreeColumnViewPresenter >> beNotResizable [
	
	self isResizable: false
]

{ #category : 'api' }
SpTreeColumnViewPresenter >> beResizable [
	
	self isResizable: true
]

{ #category : 'accessing' }
SpTreeColumnViewPresenter >> columns [
	^ columns
]

{ #category : 'api' }
SpTreeColumnViewPresenter >> hideColumnHeaders [
	"Hide the column headers"

	showColumnHeaders := false
]

{ #category : 'initialization' }
SpTreeColumnViewPresenter >> initialize [

	super initialize.
	columns := #().
	
	self beSingleSelection.
	self activateOnDoubleClick.
	self beResizable.
	self showColumnHeaders.
	
	self registerActions
]

{ #category : 'testing' }
SpTreeColumnViewPresenter >> isResizable [

	^ isResizable
]

{ #category : 'private' }
SpTreeColumnViewPresenter >> isResizable: aBoolean [

	isResizable := aBoolean
]

{ #category : 'testing' }
SpTreeColumnViewPresenter >> isShowingColumnHeaders [
	"Answer true if the table is configured to show column headers."

	^ showColumnHeaders
]

{ #category : 'initialization' }
SpTreeColumnViewPresenter >> registerActions [

	self addActionWith: [ :action | action 
		beShortcutOnly;
		shortcut: $t ctrl unix | $t ctrl win | $t command mac;
		action: [ self showContextMenu ] ]
]

{ #category : 'api' }
SpTreeColumnViewPresenter >> showColumnHeaders [
	"Show column headers"

	showColumnHeaders := true
]

{ #category : 'private' }
SpTreeColumnViewPresenter >> showContextMenu [

	self withAdapterDo: [ :anAdapter | anAdapter showContextMenu ]
]

{ #category : 'api - events' }
SpTreeColumnViewPresenter >> whenColumnsChangedDo: aBlock [
	"Inform when columns have changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"	
	
	self property: #columns whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpTreeColumnViewPresenter >> whenIsResizableChangedDo: aBlock [
	"Inform when resizable property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"
	
	self property: #isResizable whenChangedDo: aBlock
]
