Class {
	#name : 'SpMorphicTreeColumnViewDataSource',
	#superclass : 'SpMorphicTreeTableDataSource',
	#instVars : [
		'rowHeights'
	],
	#category : 'Spec2-Adapters-Morphic-ListView',
	#package : 'Spec2-Adapters-Morphic-ListView'
}

{ #category : 'accessing' }
SpMorphicTreeColumnViewDataSource >> cellColumn: column row: rowIndex [
	| cell item contentPresenter contentMorph |

	item := self elementAt: rowIndex.

	cell := FTIndentedCellMorph new.
	(self isFirstColumn: column) ifTrue: [
		cell indentBy: (self cellIndentFor: item).
		cell addMorphBack: (self buttonFor: item) ].

	contentPresenter := column setupAction value: self model.	
	column bindAction 
		value: contentPresenter
		value: item data.
		
	contentMorph := contentPresenter build.
	contentMorph setProperty: #presenter toValue: contentPresenter.
	
	"register for height"
	rowHeights at: rowIndex put: contentMorph height.

	self setHeaderColumnLazyProperties: column.
		
	^ cell addMorphBack: contentMorph
]

{ #category : 'initialization' }
SpMorphicTreeColumnViewDataSource >> initialize [

	super initialize.
	rowHeights := Dictionary new
]

{ #category : 'accessing' }
SpMorphicTreeColumnViewDataSource >> rowHeight: index [

	^ rowHeights 
		at: index 
		ifAbsent: [ super rowHeight: index ]
]

{ #category : 'testing' }
SpMorphicTreeColumnViewDataSource >> shouldDisplayExpandableArrowFor: item [

	^ (self canDisplayChildrenOf: item) 
		and: [ item hasChildren ]
]
