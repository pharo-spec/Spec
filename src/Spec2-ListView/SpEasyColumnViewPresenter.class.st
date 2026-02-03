"
An easy presenter for a column view.
A column view has columns to display information. 

### Adding column 
In addition of the column types that can be added (calling `addColum:`)  that has to receive one element of the `SpTableColumn` hierarchy 

### Defining column cell presenters
The easy column view presenter can receive as column a `SpEasyColumnViewColumn` which will receive any presenter (with certain rules to follow) to be used as any arbitrary presenter. Please visit that class to check its usage.
"
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
		application: SpApplication new;
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
	
	contentView columns: (aCollection collect: #asColumnViewColumn)
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
