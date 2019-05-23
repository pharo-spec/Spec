"
I am the common morph to represent a text area. I should be created by my model, a RubScrolledTextModel. The tool should talk to my model and not me directly 
"
Class {
	#name : #SpecRubScrolledTextMorph,
	#superclass : #RubScrolledTextMorph,
	#instVars : [
		'askBeforeDiscardingEdits'
	],
	#category : #'Spec-Pharo7To8Compatibility'
}

{ #category : #'instance creation' }
SpecRubScrolledTextMorph class >> on: aModel [ 
	^ self new on: aModel
]

{ #category : #accessing }
SpecRubScrolledTextMorph >> askBeforeDiscardingEdits: anObject [
	askBeforeDiscardingEdits := anObject
]

{ #category : #accessing }
SpecRubScrolledTextMorph >> canDiscardEdits [
	^ (self hasUnacceptedEdits and: [askBeforeDiscardingEdits]) not

]

{ #category : #accessing }
SpecRubScrolledTextMorph >> initialize [
	askBeforeDiscardingEdits := true.
	super initialize
]
