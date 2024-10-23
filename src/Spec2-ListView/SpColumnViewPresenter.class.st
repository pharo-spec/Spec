Class {
	#name : 'SpColumnViewPresenter',
	#superclass : 'SpAbstractListPresenter',
	#instVars : [
		'#columns => ObservableSlot',
		'#isResizable => ObservableSlot',
		'#showColumnHeaders => ObservableSlot'
	],
	#category : 'Spec2-ListView-Widget',
	#package : 'Spec2-ListView',
	#tag : 'Widget'
}

{ #category : 'specs' }
SpColumnViewPresenter class >> adapterName [

	^ #ColumnViewAdapter
]

{ #category : 'examples' }
SpColumnViewPresenter class >> example [
	
	^ self new
		application: (SpApplication new useBackend: #Gtk);
		addColumnTitle: 'Class' 
			setup: [ :aPresenter | aPresenter newLabel ] 
			bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		items: Smalltalk allClasses;
		open
]

{ #category : 'examples' }
SpColumnViewPresenter class >> exampleActivateOnDoubleClick [

	^ self new
		  application: (SpApplication new useBackend: #Gtk);
		  isActiveOnDoubleClick;
		  addColumnTitle: 'Class'
		  setup: [ :aPresenter | aPresenter newLabel ]
		  bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		  items: Smalltalk allClasses;
		  whenActivatedDo: [ :selection | selection selectedItem crTrace ];
		  open
]

{ #category : 'examples' }
SpColumnViewPresenter class >> exampleResizableColumns [
	
	^ self new
		application: (SpApplication new useBackend: #Gtk);
		beResizable;
		items: Smalltalk allClasses;
		addColumnTitle: 'Class' 
			setup: [ :aPresenter | aPresenter newLabel ] 
			bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		addColumnTitle: 'Lines of code' 
			setup: [ :aPresenter | aPresenter newLabel ] 
			bind: [ :aPresenter :aClass | aPresenter label: aClass linesOfCode asString ];		
		open
]

{ #category : 'examples' }
SpColumnViewPresenter class >> exampleWithIcons [
	
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
		items: Smalltalk allClasses;
		open
]

{ #category : 'api' }
SpColumnViewPresenter >> addColumn: aColumn [
	"Add a column to the table. A column should be an instance of `SpTableColumn`"

	columns := columns copyWith: aColumn
]

{ #category : 'api' }
SpColumnViewPresenter >> addColumnTitle: aTitle setup: setupBlock bind: bindBlock [

	^ self addColumn: (SpColumnViewColumn 
		newTitle: aTitle
		setup: setupBlock
		bind: bindBlock)
]

{ #category : 'api' }
SpColumnViewPresenter >> addColumns: aCollection [
	"Add a list of columns.
	 `aCollection` is a list of instances of `SpTableColumn`"

	aCollection do: [ :each | self addColumn: each ]
]

{ #category : 'api' }
SpColumnViewPresenter >> alternateRowsColor [
	"Will alternate Rows color for a better reading: one row lighter, the next row darker. 
	 NOTE: Behavior in different backends may be slightly different."

	self withAdapterPerformOrDefer: [ :anAdapter | 
		anAdapter alternateRowsColor ]
]

{ #category : 'api' }
SpColumnViewPresenter >> beNotResizable [
	
	self isResizable: false
]

{ #category : 'api' }
SpColumnViewPresenter >> beResizable [
	
	self isResizable: true
]

{ #category : 'accessing' }
SpColumnViewPresenter >> columns [
	^ columns
]

{ #category : 'accessing' }
SpColumnViewPresenter >> columns: aCollection [ 
	
	columns := #().
	aCollection do: [ :each |
		self addColumn: each  ]
]

{ #category : 'api' }
SpColumnViewPresenter >> hideColumnHeaders [
	"Hide the column headers"

	showColumnHeaders := false
]

{ #category : 'initialization' }
SpColumnViewPresenter >> initialize [

	super initialize.
	self showColumnHeaders.
	columns := #()
]

{ #category : 'testing' }
SpColumnViewPresenter >> isResizable [

	^ isResizable
]

{ #category : 'private' }
SpColumnViewPresenter >> isResizable: aBoolean [

	isResizable := aBoolean
]

{ #category : 'testing' }
SpColumnViewPresenter >> isShowingColumnHeaders [
	"Answer true if the table is configured to show column headers."

	^ showColumnHeaders
]

{ #category : 'api' }
SpColumnViewPresenter >> showColumnHeaders [
	"Show column headers"

	showColumnHeaders := true
]

{ #category : 'api - events' }
SpColumnViewPresenter >> whenColumnsChangedDo: aBlock [
	"Inform when columns have changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"	
	
	self property: #columns whenChangedDo: aBlock
]

{ #category : 'api - events' }
SpColumnViewPresenter >> whenIsResizableChangedDo: aBlock [
	"Inform when resizable property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"
	
	self property: #isResizable whenChangedDo: aBlock
]