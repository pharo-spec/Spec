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
		beRowNotHomogeneous;
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
