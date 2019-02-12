Class {
	#name : #MorphicColumnedListAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #factory }
MorphicColumnedListAdapter >> addModelTo: tableMorph [

	self model columns do: [ :each | tableMorph addColumn: (self newColumnFrom: each) ].
	self ensureAtLeastOneColumnIn: tableMorph.

	self isResizable ifTrue: [ tableMorph beResizable ] ifFalse: [ tableMorph beNotResizable ].
	
	tableMorph setMultipleSelection: self model isMultiSelection.

	self presenter isShowingColumnHeaders 
		ifTrue: [ 
			tableMorph
				showColumnHeaders;
				refresh ]
		ifFalse: [ 
			tableMorph
				hideColumnHeaders;
				refresh ].
	self presenter whenShowColumnHeadersChangedDo: [ :showColumns |
		self refreshShowColumnHeaders.
	].
	
	tableMorph
		onAnnouncement: FTSelectionChanged
			send: #selectionChanged:
			to: self;
		onAnnouncement: FTStrongSelectionChanged
			send: #strongSelectionChanged:
			to: self;
		yourself.

	tableMorph dataSource: self newDataSource
]

{ #category : #factory }
MorphicColumnedListAdapter >> buildWidget [
	| tableMorph |
	tableMorph := FTTableMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.

	self addModelTo: tableMorph.

	^ tableMorph
]

{ #category : #factory }
MorphicColumnedListAdapter >> defaultColumn [

	^ StringTableColumn new evaluated: #yourself
]

{ #category : #factory }
MorphicColumnedListAdapter >> ensureAtLeastOneColumnIn: tableMorph [
	self model columns ifNotEmpty: [ ^ self ].
	tableMorph addColumn: (self newColumnFrom: self defaultColumn)
]

{ #category : #testing }
MorphicColumnedListAdapter >> isResizable [
	^ self model isResizable
]

{ #category : #testing }
MorphicColumnedListAdapter >> isShowingColumnHeaders [
	^ self model isShowingColumnHeaders
]

{ #category : #'private factory' }
MorphicColumnedListAdapter >> newColumnFrom: aTableColumn [

	^ (MorphicTableColumn on: aTableColumn)
		width: aTableColumn width;
		yourself
]

{ #category : #'private factory' }
MorphicColumnedListAdapter >> newDataSource [ 

	^ SpecListFastTableDataSource new
		model: self model;
		yourself
		
]

{ #category : #factory }
MorphicColumnedListAdapter >> refreshShowColumnHeaders [
	
	self presenter isShowingColumnHeaders 
		ifTrue: [ 
			self widget
				showColumnHeaders;
				refresh ]
		ifFalse: [ 
			self widget
				hideColumnHeaders;
				refresh ]
]

{ #category : #refreshing }
MorphicColumnedListAdapter >> refreshWidgetSelection [
	| rowIndexes |
	rowIndexes := self presenter selection selectedIndexes.
	rowIndexes = self widget selectedRowIndexes
		ifTrue: [ ^ self ].
	rowIndexes isEmpty
		ifTrue: [ self widget basicSelectRowIndexes: #() ]
		ifFalse: [ self widget basicSelectRowIndexes: rowIndexes ].
	^ self widget refresh
]

{ #category : #factory }
MorphicColumnedListAdapter >> selectionChanged: ann [

	| diff |
	self presenter selection isMultipleSelection
		ifTrue: [ self presenter selection
				selectIndexes: (ann newSelectedRowIndexes reject: [ :e | e = 0 ]) ].

	self presenter selection isMultipleSelection
		ifFalse: [ self presenter selection
				selectIndex:
					(ann newSelectedRowIndexes
						ifNotEmpty: [ :indexes | indexes first ]
						ifEmpty: [ 0 ]) ].
	
	diff := ann newSelectedRowIndexes difference: ann oldSelectedRowIndexes.
	(diff notEmpty and: [ self presenter activatesOnSingleClick ])
		ifTrue: [ self presenter doActivateAtIndex: diff last ].

	ann newSelectedRowIndexes ifNotEmpty: [ ^ self ].
	self presenter selection unselectAll.
]

{ #category : #factory }
MorphicColumnedListAdapter >> strongSelectionChanged: aFTStrongSelectionChanged [ 
	
	self presenter activatesOnDoubleClick
		ifTrue: [ self presenter doubleClickAtIndex: aFTStrongSelectionChanged selectedRowIndex ]
]
