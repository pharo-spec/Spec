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

{ #category : #deprecation }
MorphicTreeTableAdapter class >> isDeprecated [ 

	^ true
]

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

	tableMorph dataSource: self newDataSource
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

	^ MorphicTableDataSource new 
		elements: self model items;
		yourself
]

{ #category : #private }
MorphicTreeTableAdapter >> rootForItems: aCollection [

	^ FTRootItem new
		data: aCollection;
		yourself
]
