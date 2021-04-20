"
! Style properties (==SpStyleProperty==)

Style properties define different kind of properties a morphic component can have. There are several types of properties, defined as: 

- *class:SpStyleContainer*
- *class:SpStyleDraw*
- *class:SpStyleFont*
- *class:SpStyleGeometry*
"
Class {
	#name : #SpStyleProperty,
	#superclass : #SpPropertyStyle,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #testing }
SpStyleProperty class >> isDeprecated [ 
	^ true
]
