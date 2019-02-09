Class {
	#name : #MorphicStyleSheetProperty,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'Spec-MorphicAdapters-StyleSheet'
}

{ #category : #'instance creation' }
MorphicStyleSheetProperty class >> value: anObject [ 

	^ self new value: anObject
]

{ #category : #operations }
MorphicStyleSheetProperty >> applyTo: aMorph [
]

{ #category : #accessing }
MorphicStyleSheetProperty >> name [

	^ self subclassResponsibility
]

{ #category : #accessing }
MorphicStyleSheetProperty >> value [

	^ value
]

{ #category : #accessing }
MorphicStyleSheetProperty >> value: anObject [

	value := anObject
]
