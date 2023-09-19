Class {
	#name : 'SpRubScrolledTextMorph',
	#superclass : 'RubScrolledTextMorph',
	#category : 'Spec2-Adapters-Morphic-Support',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Support'
}

{ #category : 'drag and drop' }
SpRubScrolledTextMorph >> acceptDroppingMorph: aTransferMorph event: anEvent [

	^ self model model acceptDrop cull: (SpDragAndDropTransfer new
			   passenger: aTransferMorph passenger;
			   yourself)
]

{ #category : 'accessing' }
SpRubScrolledTextMorph >> drawKeyboardFocus: aBoolean [ 
	
	self drawFocusBorder: aBoolean
]

{ #category : 'accessing - scrollbars' }
SpRubScrolledTextMorph >> registerScrollChanges: aSelector [

	self announcer 
		when: PaneScrolling 
		send: aSelector
		to: self model
]

{ #category : 'accessing - scrollbars' }
SpRubScrolledTextMorph >> scrollerOffsetChanged [

	super scrollerOffsetChanged.
	self announcer
		announce:
			(PaneScrolling new
				step: self scrollPane hScrollbarValue @ self scrollPane vScrollbarValue;
				scrollPane: self scrollPane;
				yourself)
]

{ #category : 'drag and drop' }
SpRubScrolledTextMorph >> wantsDroppedMorph: aTransferMorph event: anEvent [

	^ aTransferMorph isTransferable and: [ 
		  self model model wantsDrop cull: (SpDragAndDropTransfer new
				   passenger: aTransferMorph passenger;
				   yourself) ]
]
