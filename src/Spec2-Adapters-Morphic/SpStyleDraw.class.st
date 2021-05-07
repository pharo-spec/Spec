"
! Draw property (==SpStyleDraw==)

Draw properties control how the component (morph) will be draw.
I keep this properties: 

- color: foreground color for the morph if it applies (if the morph understands #color:).
- backgroundColor: background color if it applies (if the morph understands #backgroundColor:).

See *method:SpStyleDraw#color* and *method:SpStyleDraw#backgroundColor*

!! Usage
The identifier of draw in the stylesheet is ==Draw==.

[[[
Draw { 
	#color: #red,
	#backgroundColor: '00FF00'
}
]]]
"
Class {
	#name : #SpStyleDraw,
	#superclass : #SpDrawStyle,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #testing }
SpStyleDraw class >> isDeprecated [ 
	^ true
]
