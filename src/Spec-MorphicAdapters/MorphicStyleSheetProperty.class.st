Class {
	#name : #MorphicStyleSheetProperty,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Spec-MorphicAdapters-StyleSheet'
}

{ #category : #operations }
MorphicStyleSheetProperty >> applyTo: aMorph [
]

{ #category : #accessing }
MorphicStyleSheetProperty >> name [

	^ self subclassResponsibility
]
