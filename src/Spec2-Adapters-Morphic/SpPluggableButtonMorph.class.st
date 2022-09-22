Class {
	#name : #SpPluggableButtonMorph,
	#superclass : #PluggableButtonMorph,
	#instVars : [
		'backgroundColor'
	],
	#category : #'Spec2-Adapters-Morphic-Button'
}

{ #category : #accessing }
SpPluggableButtonMorph >> backgroundColor [

	^ backgroundColor
]

{ #category : #accessing }
SpPluggableButtonMorph >> backgroundColor: aColor [

	backgroundColor := aColor.
	self fillStyle: (SolidFillStyle color: aColor)
]

{ #category : #accessing }
SpPluggableButtonMorph >> borderWidth: aNumber [

	super borderWidth: aNumber.
	self borderStyle: (BorderStyle 
		width: aNumber 
		color: self theme borderColor)
]
