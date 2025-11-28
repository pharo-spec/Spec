Class {
	#name : 'SpEasyColumnViewPresenter',
	#superclass : 'SpAbstractEasyListViewPresenter',
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'examples' }
SpEasyColumnViewPresenter class >> example [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: SpApplication new;
		items: self environment allClasses;
		addColumn: (SpStringTableColumn new 
			title: 'Class';
			evaluated: [ :each | each name ];
			yourself);
		addColumn: (SpStringTableColumn new 
			title: 'Lines of code';
			evaluated: [ :each | each linesOfCode ];
			yourself);
		open
]

{ #category : 'examples' }
SpEasyColumnViewPresenter class >> exampleActivateOnDoubleClick [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: (SpApplication new useBackend: #Gtk);
		items: self environment allClasses;
		addColumn: (SpStringTableColumn new 
			title: 'Class';
			evaluated: [ :each | each name ];
			yourself);
		addColumn: (SpStringTableColumn new 
			title: 'Lines of code';
			evaluated: [ :each | each linesOfCode ];
			yourself);
		activateOnDoubleClick;
		whenActivatedDo: [ :selection| selection selectedItem crTrace ];
		open
]

{ #category : 'examples' }
SpEasyColumnViewPresenter class >> exampleResizableColumns [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: SpApplication new;
		items: self environment allClasses;
		beResizable;
		addColumn: (SpStringTableColumn new 
			title: 'Class';
			evaluated: [ :each | each name ];
			yourself);
		addColumn: (SpStringTableColumn new 
			title: 'Lines of code';
			evaluated: [ :each | each linesOfCode ];
			yourself);
		open
]

{ #category : 'examples' }
SpEasyColumnViewPresenter class >> exampleSortableColumns [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: (SpApplication new useBackend: #Gtk);
		items: SpPresenter subclasses;
		beResizable;
		addColumn: (SpStringTableColumn new 
			title: 'Class';
			evaluated: [ :each | each name ];
			beSortable;
			yourself);
		addColumn: (SpStringTableColumn new 
			title: 'Lines of code';
			evaluated: [ :each | each linesOfCode ];
			yourself);
		open
]

{ #category : 'examples' }
SpEasyColumnViewPresenter class >> exampleWithColumnWidth [
	"This example show the simples list view you can make: A list with a label"
	
	self new
		application: SpApplication new;
		items: self environment allClasses;
		addColumn: (SpStringTableColumn new 
			title: 'Class';
			evaluated: [ :each | each name ];
			yourself);
		addColumn: (SpStringTableColumn new 
			title: 'Lines of code';
			evaluated: [ :each | each linesOfCode ];
			width: 50;
			yourself);
		open
]

{ #category : 'api' }
SpEasyColumnViewPresenter >> addColumn: aColumn [

	contentView addColumn: aColumn asColumnViewColumn
]

{ #category : 'api' }
SpEasyColumnViewPresenter >> beNotResizable [

	contentView beNotResizable
]

{ #category : 'api' }
SpEasyColumnViewPresenter >> beResizable [

	contentView beResizable
]

{ #category : 'simulation' }
SpEasyColumnViewPresenter >> clickAtIndex: aNumber [

	contentView clickAtIndex: aNumber
]

{ #category : 'api' }
SpEasyColumnViewPresenter >> columns: aCollection [ 
	
	contentView columns: aCollection 

]

{ #category : 'api' }
SpEasyColumnViewPresenter >> contextMenu [
	
	^ contentView contextMenu
]

{ #category : 'api' }
SpEasyColumnViewPresenter >> contextMenu: aBlock [ 
	
	contentView contextMenu: aBlock
]

{ #category : 'private' }
SpEasyColumnViewPresenter >> displayValueFor: aImage [
	
	^ contentView displayValueFor: aImage
]

{ #category : 'simulation' }
SpEasyColumnViewPresenter >> doubleClickAtIndex: aNumber [

	contentView doubleClickAtIndex: aNumber
]

{ #category : 'api' }
SpEasyColumnViewPresenter >> hideColumnHeaders [
	
	contentView hideColumnHeaders
]

{ #category : 'initialization' }
SpEasyColumnViewPresenter >> initializePresenters [

	super initializePresenters.
	contentView := self newColumnView
]

{ #category : 'testing' }
SpEasyColumnViewPresenter >> isShowingColumnHeaders [
	"Answer true if the table is configured to show column headers."
	
	^ contentView isShowingColumnHeaders
]

{ #category : 'api - selection' }
SpEasyColumnViewPresenter >> selectAll [

	contentView selectAll
]

{ #category : 'api' }
SpEasyColumnViewPresenter >> showColumnHeaders [
	
	contentView showColumnHeaders
]

{ #category : 'api - selection' }
SpEasyColumnViewPresenter >> unselectAll [
	
	contentView unselectAll
]

{ #category : 'api' }
SpEasyColumnViewPresenter >> updateItemsKeepingSelection: aSequenceableCollection [

	contentView updateItemsKeepingSelection: aSequenceableCollection
]

{ #category : 'api - events' }
SpEasyColumnViewPresenter >> whenIsResizableChangedDo: aBlock [
	
	contentView whenIsResizableChangedDo: aBlock

]

{ #category : 'api - events' }
SpEasyColumnViewPresenter >> whenMenuChangedDo: aBlock [ 
	
	contentView whenMenuChangedDo: aBlock
]

{ #category : 'api - events' }
SpEasyColumnViewPresenter >> whenSelectedDo: aBlock [ 
	
	contentView whenSelectedDo: aBlock
]

{ #category : 'api - events' }
SpEasyColumnViewPresenter >> whenSelectedItemChangedDo: aBlock [ 
	
	contentView whenSelectedItemChangedDo: aBlock
]
