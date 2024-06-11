Class {
	#name : 'SpEasyTreeColumnViewPresenter',
	#superclass : 'SpAbstractEasyTreeListViewPresenter',
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
}

{ #category : 'examples' }
SpEasyTreeColumnViewPresenter class >> example [

	^ self new
		application: (SpApplication new useBackend: #Gtk);
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: (SpImageTableColumn new 
				evaluated: [ :aClass | self iconNamed: aClass systemIconName]; 
				width: 50);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		open
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> addColumn: aColumn [
	"Add a column to the table. A column should be an instance of `SpTableColumn`"

	contentView addColumn: aColumn asColumnViewColumn
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> alternateRowsColor [
	" Will alternate Rows color for a better reading: one row lighter, the next row darker"
	contentView alternateRowsColor
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> beNotResizable [
	"Mark the table as 'not resizable', which means there will be not possibility to resize the 
	 columns of it."

	contentView beNotResizable
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> beResizable [
	"Mark the table as 'resizable', which means there will be a slider to resize the columns."

	contentView beResizable
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> columns [
	"Answer the columns composing this table."

	^ contentView columns
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> columns: aCollection [
	"Set all columns at once. 
	 `aCollection` is a list of instances of `SpTableColumn`"

	self flag: #TODO
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> hideColumnHeaders [
	"Hide the column headers"

	self flag: #TODO
]

{ #category : 'initialization' }
SpEasyTreeColumnViewPresenter >> initializePresenters [

	super initializePresenters.
	contentView := self newTreeColumnView
]

{ #category : 'testing' }
SpEasyTreeColumnViewPresenter >> isResizable [
	"Answer true if table allows resizing of its columns."

	^ contentView isResizable
]

{ #category : 'testing' }
SpEasyTreeColumnViewPresenter >> isShowingColumnHeaders [
	"Answer true if the table is configured to show column headers."

	self flag: #TODO.
	^ true
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> showColumnHeaders [
	"Show column headers"

	self flag: #TODO
]

{ #category : 'api - events' }
SpEasyTreeColumnViewPresenter >> whenColumnsChangedDo: aBlock [
	"Inform when columns have changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"	
	

	contentView whenColumnsChangedDo: aBlock
]

{ #category : 'api - events' }
SpEasyTreeColumnViewPresenter >> whenIsResizableChangedDo: aBlock [
	"Inform when resizable property has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	contentView whenIsResizableChangedDo: aBlock
]
