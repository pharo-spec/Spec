"
! Container properties (==SpStyleContainer==)

A container property can be applied to container elements (buttonbar, toolbar, actionbar), and define several properties: 

- borderColor: The color of the border (in case borderWidth > 0). 
- borderWidth: The width of the border.
- padding: The space between elements.

See *method:SpStyleContainer#borderColor*

!! Usage
The identifier of container in the stylesheet is ==Container==.

[[[
Container { 
	#borderColor: #blue, 
	#borderWidth: 2,
	#padding: 5
}
]]]
"
Class {
	#name : #SpStyleContainer,
	#superclass : #SpContainerStyle,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #testing }
SpStyleContainer class >> isDeprecated [ 
	^ true
]
