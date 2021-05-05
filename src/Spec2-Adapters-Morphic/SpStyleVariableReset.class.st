"
A variable to reset previous values. 
This variable has to be used when user want to override the value of a parent property and replace it for the default value.

## Example

`Geometry { #height: Reset }`
"
Class {
	#name : #SpStyleVariableReset,
	#superclass : #SpStyleResetVariable,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #testing }
SpStyleVariableReset class >> isDeprecated [ 
	^ true
]
