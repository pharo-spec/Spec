"
A variable to access environment fonts (defined in `StandardFonts class`).
This variable must be used to assign the attribute `name` of a `SpStyleFont` property.
"
Class {
	#name : #SpStyleVariableEnvironmentFont,
	#superclass : #SpStyleEnvironmentFontVariable,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #testing }
SpStyleVariableEnvironmentFont class >> isDeprecated [ 
	^ true
]
