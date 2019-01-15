Class {
	#name : #MorphicTableDataSource,
	#superclass : #FTSimpleDataSource,
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #accessing }
MorphicTableDataSource >> cellColumn: column row: rowIndex [
	| cell builder |

	cell := FTCellMorph new.
	builder := MorphicTableCellBuilder on: self.
	builder 
		cell: cell;
		rowIndex: rowIndex;
		visit: column model.
		
	^ cell
]
