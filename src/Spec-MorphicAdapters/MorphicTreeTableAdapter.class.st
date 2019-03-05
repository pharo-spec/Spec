"
I am the adapter used to realise a TreeTablePresenter.
I will create a tree table (using FTTableMorph), using the columns TableColumn* as definitions.

Is important notice here that most of the row/cell creation happens on MorphicTreeTableDataSource. Check there for some implementation details.
"
Class {
	#name : #MorphicTreeTableAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #factory }
MorphicTreeTableAdapter >> addModelTo: tableMorph [

	self model columns do: [ :each | 
		tableMorph addColumn: (self newColumnFrom: each) ].
	self ensureAtLeastOneColumnIn: tableMorph.

	self isShowingColumnHeaders 
		ifTrue: [ tableMorph showColumnHeaders ] 
		ifFalse: [ tableMorph hideColumnHeaders ].

	self isResizable 
		ifTrue: [ tableMorph beResizable ] 
		ifFalse: [ tableMorph beNotResizable ].

	tableMorph setBalloonText: self model help.
	
	tableMorph dataSource: self newDataSource.
	
	self model selection isEmpty 
		ifFalse: [ self selectInto: tableMorph path: self model selection selectedPath ].
	
	self model whenSelectionChangedDo: [ self selectInto: tableMorph path: self model selection selectedPath ].
	self model whenRootsChangedDo: [ tableMorph dataSource: self newDataSource ].
]

{ #category : #factory }
MorphicTreeTableAdapter >> buildWidget [
	| tableMorph |
	tableMorph := FTTableMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.

	self addModelTo: tableMorph.

	^ tableMorph
]

{ #category : #factory }
MorphicTreeTableAdapter >> defaultColumn [

	^ StringTableColumn new evaluated: #yourself
]

{ #category : #factory }
MorphicTreeTableAdapter >> ensureAtLeastOneColumnIn: tableMorph [
	self model columns ifNotEmpty: [ ^ self ].
	tableMorph addColumn: (self newColumnFrom: self defaultColumn)
]

{ #category : #testing }
MorphicTreeTableAdapter >> isResizable [
	^ self model isResizable
]

{ #category : #testing }
MorphicTreeTableAdapter >> isShowingColumnHeaders [
	^ self model isShowingColumnHeaders
]

{ #category : #'private factory' }
MorphicTreeTableAdapter >> newColumnFrom: aTableColumn [

	^ (MorphicTableColumn on: aTableColumn)
		width: aTableColumn width;
		yourself
]

{ #category : #'private factory' }
MorphicTreeTableAdapter >> newDataSource [ 

	^ MorphicTreeTableDataSource new 
		rootItem: (self rootForItems: self model roots);
		childrenBlock: [ :data :item | self model childrenFor: data ];
		yourself
]

{ #category : #private }
MorphicTreeTableAdapter >> rootForItems: aCollection [

	^ FTRootItem new
		data: aCollection;
		yourself
]

{ #category : #selecting }
MorphicTreeTableAdapter >> selectInto: aFTTableMorph path: aPath [ 
	
	| item index |
	
	item := aFTTableMorph dataSource itemAtPath: aPath expanding: true.

	item ifNil: [ aFTTableMorph selectIndex: 0. ^ self ].

	aFTTableMorph refresh.
	index := aFTTableMorph dataSource indexOfItem: item.

	aFTTableMorph selectIndex: index.
]

{ #category : #accessing }
MorphicTreeTableAdapter >> selectedItem [
	
	| selectedIndex |
	selectedIndex := self widget selectedIndex.
	
	selectedIndex = 0 ifTrue: [ ^ nil ].
	
	^ (self widget dataSource elementAt: selectedIndex) data
]
