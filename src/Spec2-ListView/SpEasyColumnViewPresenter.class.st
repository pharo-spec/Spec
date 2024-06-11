Class {
	#name : 'SpEasyColumnViewPresenter',
	#superclass : 'SpAbstractEasyListViewPresenter',
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
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

{ #category : 'api' }
SpEasyColumnViewPresenter >> hideColumnHeaders [
	
	self flag: #TODO
]

{ #category : 'initialization' }
SpEasyColumnViewPresenter >> initializePresenters [

	super initializePresenters.
	contentView := self newColumnView.

]

{ #category : 'api - events' }
SpEasyColumnViewPresenter >> whenIsResizableChangedDo: aBlock [
	
	contentView whenIsResizableChangedDo: aBlock

]
