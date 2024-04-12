"
Environment colors can change if we change the morphic theme, in that case we need to be able to react to `themeChanged` message, which will repaint the morphic components using the new values.

To be able to react this, when declaring the usage of an environment-based color (see `SpStyleEnvironmentColorVariable`), we actually set up a proxy to a color, that will access the real color from the theme when needed.

This is used exclusively in `SpStyleEnvironmentColorVariable>>#value`
"
Class {
	#name : 'SpStyleEnvironmentColorProxy',
	#superclass : 'ProtoObject',
	#instVars : [
		'colorSelector'
	],
	#category : 'Spec2-Adapters-Morphic-StyleSheet',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'StyleSheet'
}

{ #category : 'converting' }
SpStyleEnvironmentColorProxy >> asStyleVariable [

	^ SpStyleVariable newValue: self
]

{ #category : 'accessing' }
SpStyleEnvironmentColorProxy >> colorSelector: aSelector [

	colorSelector := aSelector
]

{ #category : 'reflective operations' }
SpStyleEnvironmentColorProxy >> doesNotUnderstand: aMessage [

	^ aMessage sendTo: (Smalltalk ui theme perform: colorSelector)
]

{ #category : 'hooks' }
SpStyleEnvironmentColorProxy >> fuelAccept: aGeneralMapper [

	^ aGeneralMapper visitFixedObject: self 
]

{ #category : 'accessing' }
SpStyleEnvironmentColorProxy >> instVarAt: index [
	"Primitive. Answer a fixed variable in an object. The numbering of the variables
	 corresponds to the named instance variables, followed by the indexed instance
	 variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable or indexed variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 173 error: ec>
	self primitiveFailed	
]

{ #category : 'accessing' }
SpStyleEnvironmentColorProxy >> instVarAt: index put: anObject [
	"Primitive. Store a value into a fixed variable in an object. The numbering of the
	 variables corresponds to the named instance variables, followed by the indexed
	 instance variables. Fail if the index is not an Integer or is not the index of a fixed
	 variable or indexed variable. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 174 error: ec>
	
	self primitiveFailed
]

{ #category : 'accessing' }
SpStyleEnvironmentColorProxy >> yourself [
]
