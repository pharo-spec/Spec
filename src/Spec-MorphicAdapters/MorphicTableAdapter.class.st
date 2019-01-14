Class {
	#name : #MorphicTableAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #factory }
MorphicTableAdapter >> addModelTo: tableMorph [
	
	self model columns do: [ :each |
		tableMorph addColumn: (self newColumnFrom: each) ].
	tableMorph dataSource: self newDataSource
]

{ #category : #factory }
MorphicTableAdapter >> buildWidget [
	| tableMorph |
	
	tableMorph := FTTableMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.
	self addModelTo: tableMorph.
	^ tableMorph
]

{ #category : #'private factory' }
MorphicTableAdapter >> newColumnFrom: aTableColumn [

	^ (MorphicTableColumn on: aTableColumn)
		width: aTableColumn width;
		yourself
]

{ #category : #'private factory' }
MorphicTableAdapter >> newDataSource [ 

	^ MorphicTableDataSource new 
		elements: self model items;
		yourself
]
