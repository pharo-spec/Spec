Class {
	#name : 'SpEasyTreeColumnViewPresenter',
	#superclass : 'SpAbstractEasyTreeListViewPresenter',
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
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

{ #category : 'api - drag and drop' }
SpEasyTreeColumnViewPresenter >> acceptDrop [

	^ contentView acceptDrop
]

{ #category : 'api - drag and drop' }
SpEasyTreeColumnViewPresenter >> acceptDrop: aBoolean [

	contentView acceptDrop: aBoolean
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> addColumn: aColumn [
	"Add a column to the table. A column should be an instance of `SpTableColumn`"

	contentView addColumn: aColumn asColumnViewColumn
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

{ #category : 'api - drag and drop' }
SpEasyTreeColumnViewPresenter >> dragEnabled [

	^ contentView dragEnabled
]

{ #category : 'api - drag and drop' }
SpEasyTreeColumnViewPresenter >> dragEnabled: aBoolean [

	contentView dragEnabled: aBoolean
]

{ #category : 'api - drag and drop' }
SpEasyTreeColumnViewPresenter >> dropEnabled [

	^ contentView dropEnabled
]

{ #category : 'api - drag and drop' }
SpEasyTreeColumnViewPresenter >> dropEnabled: aBoolean [

	contentView dropEnabled: aBoolean
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> hideColumnHeaders [
	"Hide the column headers"

	contentView hideColumnHeaders
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
	
	^ contentView isShowingColumnHeaders
]

{ #category : 'api' }
SpEasyTreeColumnViewPresenter >> showColumnHeaders [
	"Hide the column headers"

	contentView showColumnHeaders
]

{ #category : 'api - drag and drop' }
SpEasyTreeColumnViewPresenter >> wantsDrop: aBlock [ 
	
	contentView wantsDrop: aBlock
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

{ #category : 'enumerating' }
SpEasyTreeColumnViewPresenter >> whenDragStartDo: aBlock [

	contentView whenDragStartDo: aBlock
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

{ #category : 'private - deferring' }
SpEasyTreeColumnViewPresenter >> withAdapterPerformOrDefer: aFullBlockClosure [ 
	self shouldBeImplemented.
]
