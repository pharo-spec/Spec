"
A holder for an attribute `atomic` value.
It holds numbers, strings, symbols.
"
Class {
	#name : 'SpStyleVariable',
	#superclass : 'SpStyleAbstractVariable',
	#instVars : [
		'value'
	],
	#category : 'Spec2-Adapters-Morphic-StyleSheet',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'StyleSheet'
}

{ #category : 'instance creation' }
SpStyleVariable class >> newValue: anObject [

	^ self new 
		value: anObject;
		yourself
]

{ #category : 'ston-core' }
SpStyleVariable class >> stonName [

	^ 'Variable'
]

{ #category : 'evaluating' }
SpStyleVariable >> nonscaledValue [

	^ self value ifNil: [ 0 ]
]

{ #category : 'evaluating' }
SpStyleVariable >> preferredScaledValueWith: anObject [

	^ self value = 0 
		ifTrue: [ anObject ]
		ifFalse: [ self scaledValue ]
]

{ #category : 'evaluating' }
SpStyleVariable >> preferredValueWith: anObject [

	^ self value = 0 
		ifTrue: [ anObject ]
		ifFalse: [ self value ]
]

{ #category : 'evaluating' }
SpStyleVariable >> scaledValue [

	^ self nonscaledValue * self currentWorld displayScaleFactor
]

{ #category : 'private' }
SpStyleVariable >> toColor: aColorOrSymbol [

	"Try if color"
	aColorOrSymbol isSymbol ifFalse: [ ^ aColorOrSymbol ].
	"Try by name"
	(Color named: aColorOrSymbol) ifNotNil: [ :aColor | ^ aColor ]. 
	"Try by HEX (CSS style)"				
	^ Color fromHexString: aColorOrSymbol
]

{ #category : 'evaluating' }
SpStyleVariable >> value [

	^ value
]

{ #category : 'accessing' }
SpStyleVariable >> value: anObject [

	value := anObject
]

{ #category : 'evaluating' }
SpStyleVariable >> valueAsColor [

	^ self toColor: self value
]
