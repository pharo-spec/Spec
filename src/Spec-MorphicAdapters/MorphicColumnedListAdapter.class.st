Class {
	#name : #MorphicColumnedListAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #factory }
MorphicColumnedListAdapter >> addModelTo: tableMorph [

	self model columns do: [ :each | tableMorph addColumn: (self newColumnFrom: each) ].
	self ensureAtLeastOneColumnIn: tableMorph.

	self isShowingColumnHeaders ifTrue: [ tableMorph showColumnHeaders ] ifFalse: [ tableMorph hideColumnHeaders ].

	self isResizable ifTrue: [ tableMorph beResizable ] ifFalse: [ tableMorph beNotResizable ].

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

	^ MorphicTableDataSource new 
		elements: self model items;
		yourself
]
