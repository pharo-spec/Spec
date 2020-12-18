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
	rowAndColumn := (self container rowAndColumnIndexContainingPoint:
		                 anEvent position) ifNil: [ 0 ].

	^ SpDragAndDropTransferToTable new
		  passenger: aTransferMorph passenger;
		  row: rowAndColumn first;
		  column: rowAndColumn second;
		  yourself
]

{ #category : #'drag and drop' }
SpFTTableMorph >> wantsDroppedMorph: aTransferMorph event: anEvent [

	aTransferMorph isTransferable ifFalse: [ ^ false ].
	^ self dataSource model wantsDrop cull:
		  (self transferFrom: aTransferMorph event: anEvent)
]
