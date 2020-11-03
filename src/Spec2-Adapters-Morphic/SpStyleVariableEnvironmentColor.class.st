Class {
	#name : #SpStyleVariableEnvironmentColor,
	#superclass : #SpStyleVariableEnvironment,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #'ston-core' }
SpStyleVariableEnvironmentColor class >> stonName [

	^ 'EnvironmentColor'
]

{ #category : #evaluating }
SpStyleVariableEnvironmentColor >> value [

	self name ifNil: [ ^ nil ].
	^ Smalltalk ui theme perform: (self name, 'Color') asSymbol
]

{ #category : #evaluating }
SpStyleVariableEnvironmentColor >> valueAsColor [
	
	^ self value
]
