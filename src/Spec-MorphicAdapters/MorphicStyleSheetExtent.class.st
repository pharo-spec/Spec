Class {
	#name : #MorphicStyleSheetExtent,
	#superclass : #MorphicStyleSheetProperty,
	#category : #'Spec-MorphicAdapters-StyleSheet'
}

{ #category : #operations }
MorphicStyleSheetExtent >> applyTo: aMorph [
	| width height |
	
	self value ifNil: [ ^ self ].
	
	width := self value x.
	height := self value y.
	
	width = 0 ifFalse: [ aMorph hResizing: #rigid; width: width ].
	height = 0 ifFalse: [ aMorph vResizing: #rigid; height: height ]
]

{ #category : #accessing }
MorphicStyleSheetExtent >> name [

	^ #extent
]
