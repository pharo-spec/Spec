"
I'm a dataSource to be used in MorphicTableAdapter to realise a TablePresenter.
I define my cells following the definition on columns (MorphicTableColumn).
I use a builder (MorphicTableCellBuilder) to realise the cell content. 
"
Class {
	#name : 'SpMorphicTableDataSource',
	#superclass : 'FTSimpleDataSource',
	#traits : 'SpTMorphicTableDataSourceCommons',
	#classTraits : 'SpTMorphicTableDataSourceCommons classTrait',
	#category : 'Spec2-Adapters-Morphic-Table',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Table'
}

{ #category : 'accessing' }
SpMorphicTableDataSource >> cellColumn: column row: rowIndex [
	| cell builder |

	cell := FTCellMorph new.
	builder := SpMorphicTableCellBuilder on: self.
	builder 
		cell: cell;
		rowIndex: rowIndex;
		visit: column model.
	self setHeaderColumnLazyProperties: column.
		
	^ cell
]

{ #category : 'accessing' }
SpMorphicTableDataSource >> elements [ 
	
	^ elements ifNil: [
		self model 
			ifNotNil: [:m| m items]
			ifNil: [ #() ] ]
]

{ #category : 'testing' }
SpMorphicTableDataSource >> isMatch: anObject pattern: aString [
	| text |
	
	text := (self toString: anObject) trimBoth asLowercase.
	^ text beginsWith: aString
]

{ #category : 'accessing' }
SpMorphicTableDataSource >> resetElements [

	elements := nil
]

{ #category : 'accessing' }
SpMorphicTableDataSource >> searchText: aString [
	
	aString isEmptyOrNil ifTrue: [ ^ #() ].
	^ Array streamContents: [ :stream |
		self elements withIndexDo: [ :each :index |
			(self model performSearch: each matching: aString)
				ifTrue: [ stream nextPut: index ] ] ]
]
