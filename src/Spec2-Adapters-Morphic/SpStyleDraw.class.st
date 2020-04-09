"
I'm a style to control how a widget is drawn. 
I keep properties like 

- color 
- backgroundColor
"
Class {
	#name : #SpStyleDraw,
	#superclass : #SpStyleProperty,
	#instVars : [
		'color',
		'backgroundColor'
	],
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #'ston-core' }
SpStyleDraw class >> stonName [

	^ 'Draw'
]

{ #category : #operations }
SpStyleDraw >> applyTo: aMorph [ 

	self color ifNotNil: [ :aColor | aMorph color: aColor ].
	self backgroundColor ifNotNil: [ :aColor |
		"hack to be able to decorate components that does not understand 
		 backgroundColor" 
		(aMorph respondsTo: #backgroundColor:)
			ifTrue: [ aMorph backgroundColor: aColor ]
			ifFalse: [ aMorph fillStyle: aColor ] ].
	
]

{ #category : #accessing }
SpStyleDraw >> backgroundColor [
	^ backgroundColor
]

{ #category : #accessing }
SpStyleDraw >> backgroundColor: aColorOrSymbol [

	backgroundColor := self toColor: aColorOrSymbol
]

{ #category : #accessing }
SpStyleDraw >> color [
	^ color
]

{ #category : #accessing }
SpStyleDraw >> color: aColorOrSymbol [

	color := self toColor: aColorOrSymbol
]

{ #category : #private }
SpStyleDraw >> toColor: aColorOrSymbol [

	"Try if color"
	aColorOrSymbol isSymbol ifFalse: [ ^ aColorOrSymbol ].
	"Try by name"
	(Color named: aColorOrSymbol) ifNotNil: [ :aColor | ^ aColor ]. 
	"Try by HEX (CSS style)"				
	^ Color fromHexString: aColorOrSymbol
]
