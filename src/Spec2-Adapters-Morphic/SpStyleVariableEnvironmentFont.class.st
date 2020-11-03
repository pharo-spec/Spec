Class {
	#name : #SpStyleVariableEnvironmentFont,
	#superclass : #SpStyleVariableEnvironment,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #'ston-core' }
SpStyleVariableEnvironmentFont class >> stonName [

	^ 'EnvironmentFont'
]

{ #category : #accessing }
SpStyleVariableEnvironmentFont >> familyName [

	^ self value familyName
]

{ #category : #accessing }
SpStyleVariableEnvironmentFont >> name [

	^ super name ifNil: [ #default ]
]

{ #category : #accessing }
SpStyleVariableEnvironmentFont >> pointSize [

	^ self value pointSize
]

{ #category : #evaluating }
SpStyleVariableEnvironmentFont >> value [

	^ StandardFonts perform: (self name, 'Font') asSymbol
]
