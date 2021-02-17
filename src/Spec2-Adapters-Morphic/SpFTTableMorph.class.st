Class {
	#name : #SpFTTableMorph,
	#superclass : #FTTableMorph,
	#category : #'Spec2-Adapters-Morphic-Support'
}

{ #category : #'drag and drop' }
SpFTTableMorph >> acceptDroppingMorph: aTransferMorph event: anEvent [

	^ self dataSource model acceptDrop cull:
		  (self transferFrom: aTransferMorph event: anEvent)
]

{ #category : #private }
SpFTTableMorph >> transferFrom: aTransferMorph event: anEvent [

	| rowAndColumn |
	rowAndColumn := self container rowAndColumnIndexContainingPoint:
		                anEvent position.

	^ dataSource model isTable
		  ifTrue: [ 
			  SpDragAndDropTransferToTable new
				  passenger: aTransferMorph passenger;
				  row: (rowAndColumn first ifNil: [ 0 ]);
				  column: (rowAndColumn second ifNil: [ 0 ]);
				  yourself ]
		  ifFalse: [ 
			  SpDragAndDropTransferToList new
				  passenger: aTransferMorph passenger;
				  index: (rowAndColumn first ifNil: [ 0 ]);
				  yourself ]
]

{ #category : #'drag and drop' }
SpFTTableMorph >> wantsDroppedMorph: aTransferMorph event: anEvent [

	aTransferMorph isTransferable ifFalse: [ ^ false ].
	^ self dataSource model wantsDrop cull:
		  (self transferFrom: aTransferMorph event: anEvent)
]
