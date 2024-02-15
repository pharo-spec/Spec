Class {
	#name : 'SpRubTextFieldArea',
	#superclass : 'RubTextFieldArea',
	#category : 'Spec2-Adapters-Morphic-Support',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Support'
}

{ #category : 'initialization' }
SpRubTextFieldArea >> defaultBounds [

	^ super defaultBounds topLeft extent: 3@3
]

{ #category : 'geometry' }
SpRubTextFieldArea >> height [

	^ super height max: 1
]

{ #category : 'accessing' }
SpRubTextFieldArea >> updateMarginsWithHeight: aNumber [
	| minHeight newMargin |

	minHeight := self textStyle lineGrid.
	newMargin := ((aNumber - minHeight) // 2) asInteger max: 0.
	self margins: (Margin 
		left: self margins left
		right: self margins right
		top: ((newMargin - 1) max: 0)
		bottom: (newMargin + 1 + ((aNumber - minHeight) \\ 2)) asInteger).
	self minHeight: aNumber.
	self forceExtentTo: self width@aNumber
]
