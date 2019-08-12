"
I'm a style to be used in morphic adaptors. 
I can be a class (which is a set of classes and properties) or a property. 
My children will define concrete implementations of each.

Most important part, a style can be applied to (using #applyTo:) a morph. This morph will be the morph generated in an adaptor.
"
Class {
	#name : #SpStyle,
	#superclass : #Object,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #operations }
SpStyle >> applyTo: aMorph [

	self subclassResponsibility
]

{ #category : #testing }
SpStyle >> isStyleClass [

	^ false
]

{ #category : #testing }
SpStyle >> isStyleProperty [

	^ false
]
