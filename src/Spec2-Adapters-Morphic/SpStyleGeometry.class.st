"
! Geometry properties (==SpStyleGeometry==)

Geometry properties controls how the component (morph) will be arranged within its layout.

- hResizing: the component can be resized horizontally? (boolean, default depends on how the morph behaves outside spec)
- vResizing: the component can be resized vertically? (boolean, default depends on how the morph behaves outside spec)
- width: fixed width of the component.
- height: fixed height of the component.
- minWidth: minimum width of the component (to use when ==hResizing=true==) 
- minHeight: minimum height of the component (to use when ==vResizing=true==) 
- maxWidth: maximum width of the component (to use when ==hResizing=true==) 
- maxHeight: maximum height of the component (to use when ==vResizing=true==) 

!! Usage
The identifier of geometry in the stylesheet is ==Geometry==.

[[[
Geometry { 
	#hResizing: false,
	#vResizing: false,
	#width: 100,
	#height: 25,
	#minWidth: 50,
	#minHeight: 25,
	#maxWidth: 150,
	#maxHeight: 25
}
]]]
"
Class {
	#name : #SpStyleGeometry,
	#superclass : #SpGeometryStyle,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #testing }
SpStyleGeometry class >> isDeprecated [ 
	^ true
]
