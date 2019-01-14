Class {
	#name : #MorphicTreeTableDataSource,
	#superclass : #FTTreeDataSource,
	#category : #'Spec-MorphicAdapters-Table'
}

{ #category : #accessing }
MorphicTreeTableDataSource >> cellColumn: column row: rowIndex [

	^ self 
		newCellFor: (self elementAt: rowIndex)
		column: column
]

{ #category : #accessing }
MorphicTreeTableDataSource >> cellIndentFor: item [ 

	^ item depth * 16
]

{ #category : #testing }
MorphicTreeTableDataSource >> isFirstColumn: column [
	
	^ (table columns indexOf: column) = 1
]

{ #category : #accessing }
MorphicTreeTableDataSource >> newCellFor: item column: column [
	| cell |
	
	cell := FTIndentedCellMorph new.
	cell indentBy: (self cellIndentFor: item).
	(self isFirstColumn: column) ifTrue: [
		cell addMorphBack: (self buttonFor: item) ].
	(column readObject: item data) ifNotNil: [ :object |
		cell addMorphBack: object asMorph asReadOnlyMorph ].
	
	^ cell 
]

{ #category : #accessing }
MorphicTreeTableDataSource >> rootItem: anItem [

	super rootItem: anItem.
	self addSourceToRootItem
]
