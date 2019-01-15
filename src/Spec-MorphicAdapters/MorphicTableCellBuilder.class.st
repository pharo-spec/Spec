Class {
	#name : #MorphicTableCellBuilder,
	#superclass : #MorphicTableColumnVisitor,
	#instVars : [
		'dataSource',
		'rowIndex',
		'cell'
	],
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #'instance creation' }
MorphicTableCellBuilder class >> on: aDataSource [

	^ self new dataSource: aDataSource
]

{ #category : #accessing }
MorphicTableCellBuilder >> cell [
	^ cell
]

{ #category : #accessing }
MorphicTableCellBuilder >> cell: anObject [
	cell := anObject
]

{ #category : #accessing }
MorphicTableCellBuilder >> dataSource [
	^ dataSource
]

{ #category : #accessing }
MorphicTableCellBuilder >> dataSource: anObject [
	dataSource := anObject
]

{ #category : #private }
MorphicTableCellBuilder >> item [ 

	^ self itemOf: (self dataSource elementAt: self rowIndex)
]

{ #category : #private }
MorphicTableCellBuilder >> itemOf: anObject [ 

	^ anObject
]

{ #category : #accessing }
MorphicTableCellBuilder >> rowIndex [
	^ rowIndex
]

{ #category : #accessing }
MorphicTableCellBuilder >> rowIndex: anObject [
	rowIndex := anObject
]

{ #category : #visiting }
MorphicTableCellBuilder >> visitImageColumn: aTableColumn [

	self visitStringColumn: aTableColumn
]

{ #category : #visiting }
MorphicTableCellBuilder >> visitStringColumn: aTableColumn [
	| object morph |

	object := aTableColumn readObject: self item. 
	object ifNil: [ ^ self ]. 

	morph := 	object asMorph.
	aTableColumn width ifNotNil: [ :w |
		morph 
			width: w;
			hResizing: #rigid ].
	cell addMorphBack: morph.

	

]
