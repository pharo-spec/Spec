"
A SpecInterpreter is a interpreter for spec presenters
"
Class {
	#name : #SpecInterpreter,
	#superclass : #Object,
	#instVars : [
		'spec',
		'arrayToInterpret',
		'index',
		'presenter'
	],
	#category : #'Spec-Core-Utilities'
}

{ #category : #accessing }
SpecInterpreter class >> bindings [
	"Spec bindings is a DynamicVariable. It has a default value. In order to change it you can do something like: 
	
	SpecBindings value: MorphicAdapterBindings during: [ myUI openWithSpec ].
	
	"
	
	^ SpecBindings value new
]

{ #category : #accessing }
SpecInterpreter class >> bindings: anAdapterBinding [
	self deprecated: 'Never worked.'
]

{ #category : #private }
SpecInterpreter class >> defaultBindings [
	self deprecated: 'Use #bindings instead.' transformWith: '`@receiver defaultBindings' -> '`@receiver bindings'.
	^ self bindings
]

{ #category : #accessing }
SpecInterpreter class >> hardResetBindings [
	self deprecated: 'Never worked'
]

{ #category : #protocol }
SpecInterpreter class >> interpretASpec: aSpec model: aPresenter [
	self
		deprecated: 'Use `interpretASpec: aSpec presenter: aPresenter` instead'
		transformWith: '`@receiver interpretASpec: `@statements1 model: `@statements2' -> '`@receiver interpretASpec: `@statements1 presenter: `@statements2'.
		
	^ self interpretASpec: aSpec presenter: aPresenter
]

{ #category : #protocol }
SpecInterpreter class >> interpretASpec: aSpec model: aPresenter selector: aSelector [
	self
		deprecated: 'Use `interpretASpec: aSpec presenter: aPresenter` instead'
		transformWith: '`@receiver interpretASpec: `@statements1 model: `@statements2 selector: `@statements3' -> '`@receiver interpretASpec: `@statements1 presenter: `@statements2'.
		
	^ self interpretASpec: aSpec presenter: aPresenter
]

{ #category : #protocol }
SpecInterpreter class >> interpretASpec: aSpec presenter: aPresenter [
	^ self new interpretASpec: aSpec presenter: aPresenter
]

{ #category : #'interpreting-private' }
SpecInterpreter >> actionToPerformWithSelector: selector arguments: args [

	^ spec perform: selector withArguments: args
]

{ #category : #bindings }
SpecInterpreter >> bindings [

	^ self class bindings
]

{ #category : #'interpreting-private' }
SpecInterpreter >> computeSpecFrom: aSymbol [
	^ (aSymbol isSymbol and: [ aSymbol ~= #model ])
		ifTrue: [ | result |
			result := self convertSymbolOfClassToInstance: aSymbol.
			result isSpecContainer
				ifTrue: [ result := result buildAdapterWithSpec.
					self presenter addDependent: result ].
			result ]
		ifFalse: [ self class interpretASpec: aSymbol presenter: self presenter ]
]

{ #category : #bindings }
SpecInterpreter >> convertSymbolOfClassToInstance: aSymbol [
	| translatedSymbol |
	
	translatedSymbol := self bindings translateSymbol: aSymbol.
	
	^ (Smalltalk 
		at: translatedSymbol
		ifAbsent: [ ^ translatedSymbol ]) new
]

{ #category : #'interpreting-private' }
SpecInterpreter >> extractArrayToInterpretFrom: aFragment [

	arrayToInterpret := aFragment.
	
	aFragment isSpecLayout
		ifTrue: [ arrayToInterpret := aFragment asArray ].
	
	(arrayToInterpret isCollection and: [ arrayToInterpret isSequenceable ])
		ifFalse: [ ^ arrayToInterpret ].
	
	(aFragment isString or: [ aFragment isText ])
		ifTrue: [ 
			^ aFragment == #model
				ifTrue: [ self presenter ]
				ifFalse: [ self convertSymbolOfClassToInstance: aFragment ] ].
	^ nil
]

{ #category : #interpreting }
SpecInterpreter >> interpretASpec: aSpec [
	aSpec ifNil: [ ^ nil ].
	
	(self extractArrayToInterpretFrom: aSpec) ifNotNil: [ :result | ^ result ].
	
	(self retrieveSpecFrom: aSpec) ifNotNil: [ :instance | ^ instance ].

	index := 2.
	[ index <= arrayToInterpret size ]
		whileTrue: [ 
			| newInstance |
			
			newInstance := self performNextSelectorAndIncrementIndex.
			
			index > arrayToInterpret size
				ifTrue: [ ^ self returnInterpretationOf: newInstance ].
			spec := newInstance ].	
			
	"If you get here, there is a problem. Must probably it comes from the Spec which is wrongly defined"
	self assert: arrayToInterpret size < 2.
	
	self presenter spec: spec.

	^ spec
]

{ #category : #interpreting }
SpecInterpreter >> interpretASpec: aSpec model: aPresenter selector: aSelector [
	self
		deprecated: 'Use `interpretASpec: aSpec presenter: aPresenter` instead'
		transformWith: '`@receiver interpretASpec: `@statements1 model: `@statements2 selector: `@statements3' -> '`@receiver interpretASpec: `@statements1 presenter: `@statements2'.

	^ self interpretASpec: aSpec presenter: aPresenter
]

{ #category : #interpreting }
SpecInterpreter >> interpretASpec: aSpec presenter: aPresenter [
	self presenter: aPresenter.
	^ self interpretASpec: aSpec
]

{ #category : #accessing }
SpecInterpreter >> model [
	self deprecated: 'Use #presenter instead' transformWith: '`@receiver model' -> '`@receiver presenter'.
	^ self presenter
]

{ #category : #accessing }
SpecInterpreter >> model: anObject [
	self deprecated: 'Use #presenter: instead' transformWith: '`@receiver model: `@statment1' -> '`@receiver presenter: `@statment1'.
	self presenter: anObject
]

{ #category : #'interpreting-private' }
SpecInterpreter >> performNextSelectorAndIncrementIndex [
	| args numArgs selector |
	selector := arrayToInterpret at: index.
	selector isArray not
		ifTrue: [ selector := selector asSymbol.
			numArgs := selector numArgs.
			args := arrayToInterpret copyFrom: index + 1 to: index + numArgs ]
		ifFalse: [ "Here I assume that if it's not a symbol, it's a collection"
			| array |
			array := selector.
			selector := array first.
			numArgs := 0.
			args := array allButFirst ].
	args := args
		collect: [ :each | 
			self class
				interpretASpec: each
				presenter: self presenter ].
	index := index + numArgs + 1.
	^ self actionToPerformWithSelector: selector arguments: args
]

{ #category : #accessing }
SpecInterpreter >> presenter [
	^ presenter
]

{ #category : #accessing }
SpecInterpreter >> presenter: aPresenter [
	presenter := aPresenter
]

{ #category : #'interpreting-private' }
SpecInterpreter >> retrieveSpecFrom: aSpec [
	(self presenter needRebuild not and: [ self presenter spec notNil ])
		ifTrue: [ spec := self presenter spec.
			self presenter needRebuild: true.
			((spec respondsTo: #isRedrawable) and: [ spec isSpecAdapter ])
				ifFalse: [ spec := self computeSpecFrom: arrayToInterpret first ]
				ifTrue: [ spec isRedrawable
						ifTrue: [ spec removeSubWidgets ]
						ifFalse: [ ^ spec ] ] ]
		ifFalse: [ spec := self computeSpecFrom: arrayToInterpret first ].

	^ nil
]

{ #category : #'interpreting-private' }
SpecInterpreter >> returnInterpretationOf: newInstance [
	| result |
	self presenter spec: spec.
	result := self class interpretASpec: newInstance presenter: spec.
	^ (result isKindOf: ComposablePresenter)
		ifTrue: [ result buildAdapterWithSpecLayout: (result retrieveSpec: result defaultSpecSelector) ]
		ifFalse: [ result ]
]
