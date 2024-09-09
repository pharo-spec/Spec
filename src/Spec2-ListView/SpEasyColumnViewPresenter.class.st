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

{ #category : 'accessing' }
SpEasyColumnViewPresenter >> columns: aCollection [ 
	
	contentView columns: aCollection 

]

{ #category : 'api' }
SpEasyColumnViewPresenter >> contextMenu: aBlock [ 
	
	self flag: #TODO. "ignored, as this is deprecated"
]

{ #category : 'private' }
SpEasyColumnViewPresenter >> displayValueFor: aImage [
	
	^ contentView displayValueFor: aImage
]

{ #category : 'api' }
SpEasyColumnViewPresenter >> hideColumnHeaders [
	
	contentView hideColumnHeaders
]

{ #category : 'initialization' }
SpEasyColumnViewPresenter >> initializePresenters [

	super initializePresenters.
	contentView := self newColumnView.

]

{ #category : 'testing' }
SpEasyColumnViewPresenter >> isShowingColumnHeaders [
	"Answer true if the table is configured to show column headers."
	
	^ contentView isShowingColumnHeaders
]

{ #category : 'api' }
SpEasyColumnViewPresenter >> showColumnHeaders [
	
	contentView showColumnHeaders
]

{ #category : 'api - selection' }
SpEasyColumnViewPresenter >> unselectAll [
	
	contentView unselectAll
]

{ #category : 'api - events' }
SpEasyColumnViewPresenter >> whenIsResizableChangedDo: aBlock [
	
	contentView whenIsResizableChangedDo: aBlock

]

{ #category : 'enumerating' }
SpEasyColumnViewPresenter >> whenSelectedDo: aBlock [ 
	
	contentView whenSelectedDo: aBlock
]

{ #category : 'enumerating' }
SpEasyColumnViewPresenter >> whenSelectedItemChangedDo: aBlock [ 
	
	contentView whenSelectedItemChangedDo: aBlock
]
