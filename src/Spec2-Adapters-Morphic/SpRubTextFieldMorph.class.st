Class {
	#name : 'SpRubTextFieldMorph',
	#superclass : 'RubTextFieldMorph',
	#instVars : [
		'drawKeyboardFocus'
	],
	#category : 'Spec2-Adapters-Morphic-Support',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Support'
}

{ #category : 'drag and drop' }
SpRubTextFieldMorph >> acceptDroppingMorph: aTransferMorph event: anEvent [

	^ self model model acceptDrop cull: (SpDragAndDropTransfer new
			   passenger: aTransferMorph passenger;
			   yourself)
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> defaultBounds [
"answer the default bounds for the receiver"
	^ 0 @ 0 corner: 4 @ 4
]

{ #category : 'accessing' }
SpRubTextFieldMorph >> drawKeyboardFocus: aBoolean [

	self drawFocusBorder: aBoolean.
	drawKeyboardFocus := aBoolean
]

{ #category : 'drawing' }
SpRubTextFieldMorph >> drawKeyboardFocusOn: aCanvas [

	drawKeyboardFocus ifFalse: [ ^ self ].
	^ super drawKeyboardFocusOn: aCanvas
]

{ #category : 'geometry' }
SpRubTextFieldMorph >> extent: aPoint [

	self updateTextAreaMarginsWith: aPoint y.
	super extent: aPoint	
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> initialize [

	super initialize. 
	drawKeyboardFocus := true
]

{ #category : 'initialization' }
SpRubTextFieldMorph >> textAreaClass [

	^ SpRubTextFieldArea
]

{ #category : 'geometry' }
SpRubTextFieldMorph >> updateTextAreaMarginsWith: height [

	self textArea updateMarginsWithHeight: (height - 1) asInteger
]

{ #category : 'drag and drop' }
SpRubTextFieldMorph >> wantsDroppedMorph: aTransferMorph event: anEvent [

	^ aTransferMorph isTransferable and: [ 
		  self model model wantsDrop cull: (SpDragAndDropTransfer new
				   passenger: aTransferMorph passenger;
				   yourself) ]
]
