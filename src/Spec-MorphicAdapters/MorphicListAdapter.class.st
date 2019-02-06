"
I am the adapter used to bridge a ListPresenter and a PluggableListMorph
"
Class {
	#name : #MorphicListAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #'widget API' }
MorphicListAdapter >> acceptDroppingMorph: draggedMorph event: event inMorph: source [
	| item index |
	
	index := source rowAtLocation: event position.
	item := self presenter model at: index ifAbsent: [ nil ].
	
	^ self acceptDropBlock valueWithEnoughArguments: { draggedMorph model model . event. source model model. item. index }
]

{ #category : #'spec protocol' }
MorphicListAdapter >> autoDeselect: aBoolean [

	self widgetDo: [ :w | w autoDeselect: aBoolean ]
]

{ #category : #'widget API' }
MorphicListAdapter >> backgroundColorFor: anItem [
	^ self model backgroundColorFor: anItem
]

{ #category : #'widget API' }
MorphicListAdapter >> backgroundColorFor: anItem at: index [

	^ self model backgroundColorFor: anItem at: index
]

{ #category : #factory }
MorphicListAdapter >> buildWidget [
	widget := FTPluggableIconListMorphAdaptor new
			dataSource: FTPluggableIconListMorphAdaptorDataSourceWithoutDependencies new;
		   model: self model;
			hideColumnHeaders;
			beResizable;
			setMultipleSelection: self model isMultiSelection;
			doubleClickSelector: #doubleClick: ;
			basicWrapSelector: #wrapItem: ;
			dragEnabled:	self dragEnabled ;
			dropEnabled:	self dropEnabled ; 	
			setBalloonText: self help; 
			hResizing: 	#spaceFill;
			vResizing: 	#spaceFill;
			onAnnouncement: FTSelectionChanged  send: #selectionChanged: to: self;
			onAnnouncement: FTStrongSelectionChanged send: #strongSelectionChanged: to: self;
			yourself.

	self itemFilterBlock
		ifNotNil: [ :block | 
			widget
				enableFilter: (FTSpecFilter block: block);
				explicitFunction ].

	^ widget
]

{ #category : #'widget API' }
MorphicListAdapter >> getSelectionStateFor: anIndex [

	^ self model getSelectionStateFor: anIndex
]

{ #category : #'widget API' }
MorphicListAdapter >> itemFilterBlock [
	^ self model itemFilterBlock
]

{ #category : #'widget API' }
MorphicListAdapter >> listElementAt: anIndex ifAbsent: aBlock [

	^ self model listElementAt: anIndex ifAbsent: aBlock
]

{ #category : #'widget API' }
MorphicListAdapter >> listSize [

	^ self model listSize
]

{ #category : #'widget API' }
MorphicListAdapter >> menu: aMenu shifted: aBoolean [

	^ (self model menu: aMenu shifted: aBoolean) 
		
]

{ #category : #'widget API' }
MorphicListAdapter >> refreshList [

	^ self widget updateList
]

{ #category : #'widget API' }
MorphicListAdapter >> refreshWidgetList [
	
	(self widget showIndex < self widget dataSource numberOfRows
		and: [ self widget isRowIndexVisible: self widget showIndex ])
			ifFalse: [ self widget resetPosition ].
	
	self refreshWidgetSelection.

	(self widget hasSelection and: [ (self widget isRowIndexVisible: self widget selectedRowIndex) ])
		ifFalse: [ 
			self widget resetPosition.
			self widget ensureVisibleFirstSelection ].
	self widget refresh
]

{ #category : #'widget API' }
MorphicListAdapter >> refreshWidgetSelection [

	| rowIndex |
	rowIndex := self presenter selection selectedIndex.
	rowIndex = self widget selectedRowIndex ifTrue: [ ^ self ].
	rowIndex = 0
		ifTrue: [ self widget basicSelectRowIndexes: #() ]
		ifFalse: [ self widget basicSelectRowIndexes: { rowIndex } ].

	^ self widget refresh
]

{ #category : #factory }
MorphicListAdapter >> selectionChanged: ann [

	self presenter selection isMultipleSelection
		ifTrue: [ self presenter selection
				selectIndexes: ann newSelectedRowIndexes ].

	self presenter selection isMultipleSelection
		ifFalse: [ self presenter selection
				selectIndex:
					(ann newSelectedRowIndexes
						ifNotEmpty: [ :indexes | indexes first ]
						ifEmpty: [ 0 ]) ].

	ann newSelectedRowIndexes ifNotEmpty: [ ^ self ].
	self presenter selection unselectAll.
]

{ #category : #'widget API' }
MorphicListAdapter >> wrapItem: anObject index: index [

	^ self model wrapItem: anObject index: index
]
