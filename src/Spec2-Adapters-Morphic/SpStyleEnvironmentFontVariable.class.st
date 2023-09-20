"
A variable to access environment fonts (defined in `StandardFonts class`).
This variable must be used to assign the attribute `name` of a `SpStyleFont` property.
"
Class {
	#name : 'SpStyleEnvironmentFontVariable',
	#superclass : 'SpStyleEnvironmentVariable',
	#category : 'Spec2-Adapters-Morphic-StyleSheet',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'StyleSheet'
}

{ #category : 'documentation' }
SpStyleEnvironmentFontVariable class >> documentExampleCode [

	^ 'Font { #name: EnvironmentFont(#default) }'
]

{ #category : 'documentation' }
SpStyleEnvironmentFontVariable class >> documentValidValues [

	^ StandardFonts class selectors 
		select: [ :each | each endsWith: 'Font' ]
		thenCollect: [ :each | each allButLast: 4 ]
]

{ #category : 'ston-core' }
SpStyleEnvironmentFontVariable class >> stonName [

	^ 'EnvironmentFont'
]

{ #category : 'accessing' }
SpStyleEnvironmentFontVariable >> familyName [

	^ self value familyName
]

{ #category : 'accessing' }
SpStyleEnvironmentFontVariable >> name [

	^ super name ifNil: [ #default ]
]

{ #category : 'accessing' }
SpStyleEnvironmentFontVariable >> pointSize [

	^ self value pointSize
]

{ #category : 'evaluating' }
SpStyleEnvironmentFontVariable >> value [
	^ self name = 'default' 
		ifTrue: [ StandardFonts defaultFont ]
		ifFalse: [ StandardFonts perform: (self name, 'Font') asSymbol ]
]
