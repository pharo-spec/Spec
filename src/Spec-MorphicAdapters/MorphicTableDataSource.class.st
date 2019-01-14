Class {
	#name : #MorphicTableDataSource,
	#superclass : #FTSimpleDataSource,
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #accessing }
MorphicTableDataSource >> cellColumn: column row: rowIndex [
	| cell |

	cell := FTCellMorph new.
	(column readObject: (self elementAt: rowIndex)) ifNotNil: [ :object |
		cell addMorphBack: object asMorph ].
	^ cell
]
