"
! Style classes (==SpStyleClass==)

A style class define a set of properties grouped by a common name. You can think a style class of morphic a little bit as a style class of CSS, but it has several differences.
 
!! Style classes can be nested
You can nest classes to refine some properties. For example, if you have this definition: 

[[[
.application [
	.button [
		Geometry { #height: 25, #width: 100 }
		.smallButton {
			Geometry { #width: 150 }
		}
	]	
]
]]]

the result style for a button with ""smallButton"" style will have a Geometry with the form: ==Geometry { #width: 150, #height: 25 }==, which is the result of the merge of all properties, with the deepest nested property taking precedence.

!! Style classes are composable
You can compose class styles (stacking them to form a new style). This is an useful practice to add your own styles to the default definition.  

[[[language=Smalltalk  
myStyle := SpStyle defaultStyleSheet, myOwnStyleDefinition			
]]]
"
Class {
	#name : #SpStyleClass,
	#superclass : #SpClassStyle,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #testing }
SpStyleClass class >> isDeprecated [ 
	^ true
]
