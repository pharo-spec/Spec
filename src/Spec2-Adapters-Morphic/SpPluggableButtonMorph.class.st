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
SpPluggableButtonMorph >> borderStyleToUse [

	^ self borderWidth = 0 
		ifTrue: [ BorderStyle width: 0 color: Color transparent ]
		ifFalse: [ super borderStyleToUse ]
]

{ #category : #accessing }
SpPluggableButtonMorph >> borderWidth: aNumber [

	super borderWidth: aNumber.
	self borderStyle: (BorderStyle 
		width: aNumber 
		color: self theme borderColor)
]

{ #category : #accessing }
SpPluggableButtonMorph >> fillStyleToUse [

	(self backgroundColor isNil or: [ self interactionState ~= #normal ])  
		ifTrue: [ ^ super fillStyleToUse ].

	^ SolidFillStyle color: self backgroundColor
]
