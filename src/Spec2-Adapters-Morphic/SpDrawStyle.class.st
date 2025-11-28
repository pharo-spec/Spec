"
! Draw property (`SpDrawStyle`)

Draw properties control how the component (morph) will be draw.
I keep this properties: 

- color: foreground color for the morph if it applies (if the morph understands #color:).
- backgroundColor: background color if it applies (if the morph understands #backgroundColor:).

See `SpDrawStyle>>#color` and `SpDrawStyle>>#backgroundColor`

## Usage
The identifier of draw in the stylesheet is `Draw`.

```
Draw { 
	#color: #red,
	#backgroundColor: '00FF00'
}
```
"
Class {
	#name : 'SpDrawStyle',
	#superclass : 'SpPropertyStyle',
	#instVars : [
		'color',
		'backgroundColor',
		'selectionColor',
		'secondarySelectionColor',
		'alternateRowsColor'
	],
	#category : 'Spec2-Adapters-Morphic-StyleSheet',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'StyleSheet'
}

{ #category : 'ston-core' }
SpDrawStyle class >> stonName [

	^ #Draw
]

{ #category : 'accessing' }
SpDrawStyle >> alternateRowsColor [
	"WARNING: This style will not work outside lists, tables and trees."

	^ alternateRowsColor value
]

{ #category : 'accessing' }
SpDrawStyle >> alternateRowsColor: aBoolean [
	"WARNING: This style will not work outside lists, tables and trees."

	alternateRowsColor := aBoolean asStyleVariable
]

{ #category : 'operations' }
SpDrawStyle >> applyTo: aMorph [ 

	self color ifNotNil: [ :aColor | 
		(aMorph respondsTo: #barFillStyle:)
			ifTrue: [ aMorph barFillStyle: aColor asStyleVariable valueAsColor ]
			ifFalse: [ aMorph color: aColor asStyleVariable valueAsColor ] ].
	self backgroundColor ifNotNil: [ :aColor |
		"hack to be able to decorate components that does not understand 
		 backgroundColor" 
		(aMorph respondsTo: #backgroundColor:)
			ifTrue: [ aMorph backgroundColor: aColor asStyleVariable valueAsColor ]
			ifFalse: [ aMorph fillStyle: aColor asStyleVariable valueAsColor ] ].		
	self selectionColor ifNotNil: [ :aColor | 
		(aMorph respondsTo: #selectionColor:)
			ifTrue: [ aMorph selectionColor: aColor asStyleVariable valueAsColor ] ].
	self secondarySelectionColor ifNotNil: [ :aColor | 
		(aMorph respondsTo: #secondarySelectionColor:)
			ifTrue: [ aMorph secondarySelectionColor: aColor asStyleVariable valueAsColor ] ].
	alternateRowsColor ifNotNil: [ :aVariable | 
		(aMorph respondsTo: #alternateRowsColor:)
			ifTrue: [ aMorph alternateRowsColor: aVariable value ] ]		
]

{ #category : 'accessing' }
SpDrawStyle >> backgroundColor [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self backgroundColorVariable value
]

{ #category : 'accessing' }
SpDrawStyle >> backgroundColor: aColorOrSymbol [

	backgroundColor := aColorOrSymbol asStyleVariable
]

{ #category : 'accessing - variables' }
SpDrawStyle >> backgroundColorVariable [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self toVariable: backgroundColor
]

{ #category : 'accessing' }
SpDrawStyle >> color [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self colorVariable value
]

{ #category : 'accessing' }
SpDrawStyle >> color: aColorOrSymbol [

	color := aColorOrSymbol asStyleVariable
]

{ #category : 'accessing - variables' }
SpDrawStyle >> colorVariable [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self toVariable: color
]

{ #category : 'accessing' }
SpDrawStyle >> secondarySelectionColor [
   "WARNING: This style will not work outside lists, tables and trees.
    This property can be expressed as 
	 - a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	 - a named selector: ==#red==
	 - an hex string: =='FF0000'=="

	^ self secondarySelectionColorVariable value
]

{ #category : 'accessing' }
SpDrawStyle >> secondarySelectionColor: aColorOrSymbol [

	secondarySelectionColor := aColorOrSymbol asStyleVariable
]

{ #category : 'accessing - variables' }
SpDrawStyle >> secondarySelectionColorVariable [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self toVariable: secondarySelectionColor
]

{ #category : 'accessing' }
SpDrawStyle >> selectionColor [
   "WARNING: This style will not work outside lists, tables and trees.
    This property can be expressed as 
	 - a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	 - a named selector: ==#red==
	 - an hex string: =='FF0000'=="

	^ self selectionColorVariable value
]

{ #category : 'accessing' }
SpDrawStyle >> selectionColor: aColorOrSymbol [

	selectionColor := aColorOrSymbol asStyleVariable
]

{ #category : 'accessing - variables' }
SpDrawStyle >> selectionColorVariable [
  "This property can be expressed as 
	- a STON map: ==Color { #red : 1., #green : 0, #blue : 0, #alpha : 1 }==
	- a named selector: ==#red==
	- an hex string: =='FF0000'=="

	^ self toVariable: selectionColor
]
