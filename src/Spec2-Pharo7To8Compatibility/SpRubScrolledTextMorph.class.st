"
I am the common morph to represent a text area. I should be created by my model, a RubScrolledTextModel. The tool should talk to my model and not me directly 
"
Class {
	#name : #SpRubScrolledTextMorph,
	#superclass : #RubScrolledTextMorph,
	#instVars : [
		'askBeforeDiscardingEdits'
	],
	#category : #'Spec2-Pharo7To8Compatibility'
}

{ #category : #'instance creation' }
SpRubScrolledTextMorph class >> on: aModel [ 
	^ self new on: aModel
]

{ #category : #accessing }
SpRubScrolledTextMorph >> askBeforeDiscardingEdits: anObject [
	askBeforeDiscardingEdits := anObject
]

{ #category : #accessing }
SpRubScrolledTextMorph >> canDiscardEdits [
	^ (self hasUnacceptedEdits and: [askBeforeDiscardingEdits]) not

]

{ #category : #accessing }
SpRubScrolledTextMorph >> initialize [
	askBeforeDiscardingEdits := true.
	super initialize
]
