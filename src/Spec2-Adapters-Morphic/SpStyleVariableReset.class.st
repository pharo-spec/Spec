Class {
	#name : #SpStyleVariableReset,
	#superclass : #SpStyleAbstractVariable,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #'ston-core' }
SpStyleVariableReset class >> stonName [

	^ 'Reset'
]

{ #category : #'instance creation' }
SpStyleVariableReset >> fromSton: stonReader [
]

{ #category : #evaluating }
SpStyleVariableReset >> preferredValueWith: anObject [

	^ nil
]

{ #category : #evaluating }
SpStyleVariableReset >> value [

	^ nil
]
