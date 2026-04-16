"
A morphic adapter for `SpListViewPresenter`
"
Class {
	#name : 'SpMorphicListViewAdapter',
	#superclass : 'SpMorphicListAdapter',
	#category : 'Spec2-Adapters-Morphic-ListView',
	#package : 'Spec2-Adapters-Morphic-ListView'
}

{ #category : 'factory' }
SpMorphicListViewAdapter >> buildWidget [
	| datasource |
	
	datasource := self newDataSource.
	datasource model: self model.
	
	widget := self newTableWith: datasource.
	"no search on list view (it has to be provided elsewhere)"
	widget disableFunction. 
	
	self presenter whenModelChangedDo: [ widget refresh ].
	self presenter whenSelectionChangedDo: [ self refreshWidgetSelection ].
	self presenter selection whenChangedDo: [ self refreshWidgetSelection ].

	self refreshWidgetSelection.
	self configureScrolling.

	^ widget
]

{ #category : 'factory' }
SpMorphicListViewAdapter >> newDataSource [

	^ SpMorphicListViewDataSource new
]

{ #category : 'factory' }
SpMorphicListViewAdapter >> newTableWith: datasource [
	
	^ SpFTTableMorph new
		disableFunction;
		dataSource: datasource;
		hideColumnHeaders;
		beResizable;
		setMultipleSelection: self model isMultipleSelection;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		setBalloonText: self help;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		onAnnouncement: FTSelectionChanged send: #selectionChanged: to: self;
		onAnnouncement: FTStrongSelectionChanged send: #strongSelectionChanged: to: self;
		yourself
]

{ #category : 'api - selection' }
SpMorphicListViewAdapter >> selectedRowPresenter [
	| item exposedRows |
	
	item := self presenter selectedItem.
	item ifNil: [ ^ nil ].
	exposedRows := self widget container submorphs.
	^ exposedRows
		detect: [ :each | 	
			| presenter |
			"first content cell, second content the presenter"
			presenter := (each submorphs first submorphs last 
				valueOfProperty: #presenter 
				ifAbsent: [ nil ]).
			presenter model = item ]
		ifFound: [ :aRow | aRow submorphs first submorphs last valueOfProperty: #presenter ]
		ifNone: [ nil ] 
]
