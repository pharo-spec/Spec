"
! Morphic configurations

Morphic configurations will prepare your application to run in a Morphic backend. Tipically, you will not change much of what is already provided on a Pharo system, but there are several entry points you may want to extend/override: 

- *method:SpMorphicConfiguration#styleSheet*
"
Class {
	#name : 'SpMorphicConfiguration',
	#superclass : 'SpApplicationConfiguration',
	#instVars : [
		'styleSheet'
	],
	#category : 'Spec2-Morphic-Application',
	#package : 'Spec2-Morphic',
	#tag : 'Application'
}

{ #category : 'testing' }
SpMorphicConfiguration class >> isAvailableFor: aBackend inApplication: anApplication [

	^ aBackend name = #Morphic
]

{ #category : 'styling' }
SpMorphicConfiguration >> addStyleSheet: aStylesheet [

	styleSheet := self styleSheet, aStylesheet
]

{ #category : 'styling' }
SpMorphicConfiguration >> addStyleSheetFromString: aString [

	self addStyleSheet: (SpStyleVariableSTONReader fromString: aString)
]

{ #category : 'configuring' }
SpMorphicConfiguration >> configure: anApplication [

	super configure: anApplication.
	self styleSheet "Initialize stylesheet"
]

{ #category : 'testing' }
SpMorphicConfiguration >> isDarkTheme [
	
	"hacky, but works"
	^ UITheme current isKindOf: PharoDarkTheme
]

{ #category : 'private - factory' }
SpMorphicConfiguration >> newStyleSheet [

	^ SpStyle defaultStyleSheet copy
]

{ #category : 'styling' }
SpMorphicConfiguration >> styleSheet [
	"Define the default styleSheet to use in your application. You can override this and add your 
	 own application dependent styles (and you can compose them, see `SpStyle`).
	
	```Smalltalk
	^ SpStyle defaultStyleSheet copy
	```
	"
	
	^ styleSheet ifNil: [ styleSheet := self newStyleSheet ]
]

{ #category : 'styling' }
SpMorphicConfiguration >> styleSheet: aStyleSheet [

	styleSheet := aStyleSheet
]
