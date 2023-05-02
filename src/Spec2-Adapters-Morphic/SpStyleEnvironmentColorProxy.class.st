"
Environment colors can change if we change the morphic theme, in that case we need to be able to react to `themeChanged` message, which will repaint the morphic components using the new values.

To be able to react this, when declaring the usage of an environment-based color (see `SpStyleEnvironmentColorVariable`), we actually set up a proxy to a color, that will access the real color from the theme when needed.

This is used exclusively in `SpStyleEnvironmentColorVariable>>#value`
"
Class {
	#name : #SpStyleEnvironmentColorProxy,
	#superclass : #ProtoObject,
	#instVars : [
		'colorSelector'
	],
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #converting }
SpStyleEnvironmentColorProxy >> asStyleVariable [

	^ SpStyleVariable newValue: self
]

{ #category : #accessing }
SpStyleEnvironmentColorProxy >> colorSelector: aSelector [

	colorSelector := aSelector
]

{ #category : #'reflective operations' }
SpStyleEnvironmentColorProxy >> doesNotUnderstand: aMessage [

	aMessage crTrace. 
	^ aMessage sendTo: (Smalltalk ui theme perform: colorSelector)
]

{ #category : #accessing }
SpStyleEnvironmentColorProxy >> yourself [
]
