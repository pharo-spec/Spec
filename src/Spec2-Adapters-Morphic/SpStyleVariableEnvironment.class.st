Class {
	#name : #SpStyleVariableEnvironment,
	#superclass : #SpStyleAbstractVariable,
	#instVars : [
		'name'
	],
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #'ston-core' }
SpStyleVariableEnvironment class >> stonName [

	^ 'Environment'
]

{ #category : #'instance creation' }
SpStyleVariableEnvironment >> fromSton: stonReader [

	self name: stonReader parseContainedValue
]

{ #category : #testing }
SpStyleVariableEnvironment >> isEnvironmentVariable [

	^ true
]

{ #category : #accessing }
SpStyleVariableEnvironment >> name [
	^ name
]

{ #category : #accessing }
SpStyleVariableEnvironment >> name: anObject [
	name := anObject
]
