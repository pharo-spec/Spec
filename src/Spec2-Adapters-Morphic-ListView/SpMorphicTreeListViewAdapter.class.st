Class {
	#name : 'SpMorphicTreeListViewAdapter',
	#superclass : 'SpMorphicTreeAdapter',
	#category : 'Spec2-Adapters-Morphic-ListView',
	#package : 'Spec2-Adapters-Morphic-ListView'
}

{ #category : 'factory' }
SpMorphicTreeListViewAdapter >> addModelTo: tableMorph [

	tableMorph addColumn: (self newColumnFrom: self defaultColumn).

	self presenter selection isMultipleSelection ifTrue: [  
		tableMorph beMultipleSelection ].

	self isShowingColumnHeaders 
		ifTrue: [ tableMorph showColumnHeaders ] 
		ifFalse: [ tableMorph hideColumnHeaders ].

	self isSearchEnabled
		ifTrue: [ tableMorph enableSearch ]
		ifFalse: [ tableMorph disableFunction ].

	tableMorph setBalloonText: self model help.
	
	tableMorph dataSource: self newDataSource.
	
	self presenter selection isEmpty 
		ifFalse: [ self updateSelectionOf: tableMorph ].
	
	self presenter whenSelectionChangedDo: [ 
		self updateSelectionOf: tableMorph ].
	
	self presenter whenRootsChangedDo: [ 
		tableMorph selectIndexes: #().
		tableMorph dataSource: self newDataSource ].
	
	tableMorph
		onAnnouncement: FTSelectionChanged
			send: #selectionChanged:
			to: self;
		onAnnouncement: FTStrongSelectionChanged
			send: #strongSelectionChanged:
			to: self
]

{ #category : 'factory' }
SpMorphicTreeListViewAdapter >> defaultColumn [

	^ SpColumnViewColumn new
		title: self presenter headerTitle;
		setup: self presenter setupAction;
		bind: self presenter bindAction;
		yourself
]

{ #category : 'testing' }
SpMorphicTreeListViewAdapter >> isResizable [

	^ false
]

{ #category : 'testing' }
SpMorphicTreeListViewAdapter >> isShowingColumnHeaders [

	^ self presenter hasHeaderTitle
]

{ #category : 'private - factory' }
SpMorphicTreeListViewAdapter >> newColumnFrom: aTableColumn [

	^ (SpMorphicColumnViewColumn on: aTableColumn)
		width: aTableColumn width;
		yourself
]

{ #category : 'private - factory' }
SpMorphicTreeListViewAdapter >> newDataSource [ 

	^ SpMorphicTreeColumnViewDataSource new
		model: self model; 
		rootItem: (self rootForItems: self model roots);
		childrenBlock: [ :data :item | self model childrenFor: data ];
		yourself
]

{ #category : 'api - selection' }
SpMorphicTreeListViewAdapter >> selectedRowPresenter [
	| item exposedRows |
	
	item := self presenter selectedItem.
	item ifNil: [ ^ nil ].
	exposedRows := self widget container submorphs.
	^ exposedRows
		detect: [ :each | 	
			| presenter |
			"first content cell, second content the presenter"
			presenter := (each content content 
				valueOfProperty: #presenter 
				ifAbsent: [ nil ]).
			presenter model = item ]
		ifFound: [ :aRow | aRow content content valueOfProperty: #presenter ]
		ifNone: [ nil ] 
]

{ #category : 'api - selection' }
SpMorphicTreeListViewAdapter >> traversePresentersDo: aBlock excluding: aSet [
	| exposedRows |
	
	exposedRows := self widget container submorphs.
	exposedRows
		collect: [ :each | 	
			(each submorphs first submorphs last 
				valueOfProperty: #presenter 
				ifAbsent: [ nil ]) ]
		thenDo: [ :each | 
			each ifNotNil: [
				each 
					traversePresentersDo: aBlock 
					excluding: aSet ] ]
]
