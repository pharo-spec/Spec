Class {
	#name : 'SpMorphicColumnViewAdapter',
	#superclass : 'SpMorphicTableAdapter',
	#category : 'Spec2-Adapters-Morphic-ListView',
	#package : 'Spec2-Adapters-Morphic-ListView'
}

{ #category : 'factory' }
SpMorphicColumnViewAdapter >> addModelTo: tableMorph [

	"no search on column view (it has to be provided elsewhere)"
	tableMorph disableFunction.

	self model columns do: [ :each |
		tableMorph addColumn: (self newColumnFrom: each) ].
	self ensureAtLeastOneColumnIn: tableMorph.

	self isResizable 
		ifTrue: [ tableMorph beResizable ] 
		ifFalse: [ tableMorph beNotResizable ].
	
	tableMorph setMultipleSelection: self model isMultipleSelection.

	self refreshShowColumnHeaders.
	self refreshWidgetSelection.
	
	self presenter whenModelChangedDo: [ self refreshModel ].
	self presenter whenColumnsChangedDo: [ self refreshColumnsInWidget ].
	
	tableMorph setBalloonText: self help.

	self configureScrolling.

	tableMorph
		onAnnouncement: FTSelectionChanged
			send: #selectionChanged:
			to: self;
		onAnnouncement: FTStrongSelectionChanged
			send: #strongSelectionChanged:
			to: self.

	tableMorph dataSource: self newDataSource.
	
	self presenter whenSearchEnabledChangedDo: [ 
		self updateSearch ]
]

{ #category : 'testing' }
SpMorphicColumnViewAdapter >> isResizable [

	^ self presenter isResizable
]

{ #category : 'private - factory' }
SpMorphicColumnViewAdapter >> newColumnFrom: aColumnViewColumn [

	^ (SpMorphicColumnViewColumn on: aColumnViewColumn)
		width: aColumnViewColumn width;
		yourself
]

{ #category : 'private - factory' }
SpMorphicColumnViewAdapter >> newDataSource [ 

	^ SpMorphicColumnViewDataSource new
		model: self presenter;
		yourself
]

{ #category : 'enumerating' }
SpMorphicColumnViewAdapter >> traversePresentersDo: aBlock excluding: aSet [
	| exposedRows |
	
	exposedRows := self widget container submorphs 
		select: [ :each | each class = FTTableRowMorph ].
	
	(exposedRows
		flatCollect: [ :each | 	
			each submorphs collect: #presenter ])
		do: [ :each | 
			each ifNotNil: [
				each 
					traversePresentersDo: aBlock 
					excluding: aSet ] ]
]
