Class {
	#name : #SpLegacyArrayLayout,
	#superclass : #SpLegacyLayout,
	#instVars : [
		'specArray'
	],
	#category : #'Spec2-Layout-Deprecated'
}

{ #category : #'Spec2-Deprecated' }
SpLegacyArrayLayout >> array: aCollection [ 
	
	specArray := aCollection
]

{ #category : #'Spec2-Deprecated' }
SpLegacyArrayLayout >> asArray [

	^ specArray
]

{ #category : #'Spec2-Deprecated' }
SpLegacyArrayLayout >> selector [

	^ nil
]
