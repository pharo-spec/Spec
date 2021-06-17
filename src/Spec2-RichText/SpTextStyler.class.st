Class {
	#name : #SpTextStyler,
	#superclass : #Object,
	#instVars : [
		'adapter'
	],
	#category : #'Spec2-RichText'
}

{ #category : #applying }
SpTextStyler >> applyStyleTo: aString [

	^ self subclassResponsibility
]

{ #category : #enumerating }
SpTextStyler >> withAdapterDo: aBlock [

	^ adapter ifNotNil: aBlock
]
