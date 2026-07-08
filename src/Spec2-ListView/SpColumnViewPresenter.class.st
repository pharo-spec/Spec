"
A column view presenter displays tabular data. It replaces the old table presenter but is a lot more customisable, as, in opposition to the old implementation, it accepts any presenter as table cell.
"
Class {
	#name : 'SpColumnViewPresenter',
	#superclass : 'SpAbstractListPresenter',
	#traits : 'SpTSearchable',
	#classTraits : 'SpTSearchable classTrait',
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
		addColumnTitle: 'Class' 
			setup: [ :aPresenter | aPresenter newLabel ] 
			bind: [ :aPresenter :aClass | aPresenter label: aClass name ];
		items: Smalltalk allClasses;
		open
]

{ #category : 'examples' }
SpColumnViewPresenter class >> exampleActivateOnDoubleClick [

	^ self new
		  application: SpApplication new;
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
		application: SpApplication new;
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
		application: SpApplication new;
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

{ #category : 'examples' }
SpColumnViewPresenter class >> exampleWithIconsAndButtons [
	
	^ SpColumnViewPresenter new
		addColumn: (SpColumnViewColumn new 
			title: 'Class'; 
			setup: [ :aPresenter |
				| presenter |
				(presenter := aPresenter newPresenter)
					layout: (SpBoxLayout newHorizontal
						spacing: 5;
						add: presenter newImage expand: false;
						add: presenter newLabel;
						yourself);
					yourself ];
			bind: [ :aPresenter :aClass | 
				| icon image label |
				icon := Smalltalk ui icons iconNamed: aClass systemIconName.
				image := aPresenter layout children first.
				image image: icon.
				label := aPresenter layout children second.
				label label: aClass name ];
			yourself);
		addColumn: (SpColumnViewColumn new
			title: 'Actions';
			width: 60;
			setup: [ :aPresenter | | presenter |
				(presenter := aPresenter newPresenter)
					layout: (SpBoxLayout newHorizontal
						hAlignCenter;
						add: (presenter newButton 
							addStyle: 'small'; 
							yourself);
						add: (presenter newButton 
							addStyle: 'small'; 
							icon: (presenter iconNamed: #smallDelete);
							yourself);
						yourself);
					yourself ];
			bind: [ :aPresenter :aClass | | button1 button2 |
				button1 := aPresenter layout children first.
				button1 
					icon: (aPresenter iconNamed: aClass systemIconName);
					action: [ Object inform: aClass name  ].
				button2 := aPresenter layout children second.
				button2 
					action: [ Object inform: 'Will remove ', aClass name ] ];
			yourself);
		items: Smalltalk allClassesAndTraits;
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
	self initializeTSearchable.
	self showColumnHeaders.
	self beNotResizable.
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

{ #category : 'api - selection' }
SpColumnViewPresenter >> selectedRowPresenter [
	"answer the selected row presenter (the one being displayed) of the list. 
	 this is useful to attach other objects to the presenter (e.g. popovers). 
	 WARNING: Depending on the details of the implementation, this message can 
	 answer nil *even if there is a selected item*."

	self withAdapterDo: [ :anAdapter | 
		^ anAdapter selectedRowPresenter ].
		
	^ nil
]

{ #category : 'api' }
SpColumnViewPresenter >> showColumnHeaders [
	"Show column headers"

	showColumnHeaders := true
]

{ #category : 'private - traversing' }
SpColumnViewPresenter >> traversePresentersDo: aBlock excluding: aSet [

	super traversePresentersDo: aBlock excluding: aSet.
	self withAdapterDo: [ :anAdapter | 
		anAdapter 
			traversePresentersDo: aBlock 
			excluding: aSet ]
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
