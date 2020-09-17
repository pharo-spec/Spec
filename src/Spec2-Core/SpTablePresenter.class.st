"
A presenter for a table.
A table has columns with a type (See column types section).
 
**IMPORTANT:** A table presenter does not contain other presenters. Instead, it maps the model provided (See `SpAbstractListPresenter>>#items:`) with the columns defined. If you need this behavior, you will need to use `SpComponentListPresenter`.

"
Class {
	#name : #SpTablePresenter,
	#superclass : #SpAbstractListPresenter,
	#traits : 'SpTSearchable',
	#classTraits : 'SpTSearchable classTrait',
	#instVars : [
		'#columns => SpObservableSlot',
		'#showColumnHeaders => SpObservableSlot',
		'#isResizable => SpObservableSlot'
	],
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #specs }
SpTablePresenter class >> adapterName [

	^ #TableAdapter
]

{ #category : #documentation }
SpTablePresenter class >> addDocumentExtraSections: aBuilder [

	aBuilder newLine.
	aBuilder header: [ :builder | builder text: 'Column types' ] withLevel: 2.

	aBuilder unorderedListDuring: [ 
		(SpTableColumn allSubclasses sorted: #name ascending) do: [ :eachType | 
			aBuilder item: [
				aBuilder monospace: eachType name ] ] ]
]

{ #category : #documentation }
SpTablePresenter class >> addExtraSections: aBuilder [

	aBuilder newLine.
	aBuilder header: [ :builder | builder text: 'Column types' ] withLevel: 2.
	aBuilder unorderedListDuring: [ 
		(SpTableColumn allSubclasses sorted: #name ascending) do: [ :eachType | 
			aBuilder item: [
				aBuilder monospace: eachType name ] ] ]
]

{ #category : #api }
SpTablePresenter >> addColumn: aColumn [

	columns := columns copyWith: aColumn
]

{ #category : #api }
SpTablePresenter >> addColumns: aCollection [

	aCollection do: [ :each | self addColumn: each ]
]

{ #category : #api }
SpTablePresenter >> beNotResizable [
	self isResizable: false
]

{ #category : #api }
SpTablePresenter >> beResizable [
	self isResizable: true
]

{ #category : #emulating }
SpTablePresenter >> clickOnColumnHeaderAt: anIndex [
	self withAdapterDo: [ :tableAdapter | tableAdapter clickOnColumnHeaderAt: anIndex ]
]

{ #category : #accessing }
SpTablePresenter >> columns [

	^ columns
]

{ #category : #api }
SpTablePresenter >> columns: aCollection [

	columns := aCollection
]

{ #category : #api }
SpTablePresenter >> hideColumnHeaders [

	showColumnHeaders := false
]

{ #category : #initialization }
SpTablePresenter >> initialize [ 

	super initialize.
	self initializeTSearchable.
	showColumnHeaders := true.
	columns := #().
	isResizable := false
]

{ #category : #accessing }
SpTablePresenter >> isResizable [
	^ isResizable
]

{ #category : #accessing }
SpTablePresenter >> isResizable: aBoolean [
	isResizable := aBoolean
]

{ #category : #testing }
SpTablePresenter >> isShowingColumnHeaders [

	^ showColumnHeaders
]

{ #category : #private }
SpTablePresenter >> searchValueOf: anObject [
	
	^ anObject asString
]

{ #category : #api }
SpTablePresenter >> showColumnHeaders [

	showColumnHeaders := true
]

{ #category : #testing }
SpTablePresenter >> valueAtColumn: aColumn row: aRow [ 

	^ (columns at: aColumn) readObject: (self model items at: aRow)
]

{ #category : #'api-events' }
SpTablePresenter >> whenColumnsChangedDo: aBlock [
	
	self property: #columns whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpTablePresenter >> whenIsResizableChangedDo: aBlock [
	self property: #isResizable whenChangedDo: aBlock
]

{ #category : #'api-events' }
SpTablePresenter >> whenShowColumnHeadersChangedDo: aBlock [
	
	self property: #showColumnHeaders whenChangedDo: aBlock
]
