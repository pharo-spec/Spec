Class {
	#name : #SpContextInteractionModel,
	#superclass : #SpCodeInteractionModel,
	#instVars : [
		'context'
	],
	#category : #'Spec2-Code-Base'
}

{ #category : #'instance creation' }
SpContextInteractionModel class >> on: aContext [

	^ self new context: aContext
]

{ #category : #accessing }
SpContextInteractionModel >> behavior [

	^ self context receiver class
]

{ #category : #binding }
SpContextInteractionModel >> bindingOf: aString [

	"we can not call #lookupVar: without checking first as it would create the variable"

	^ (self hasBindingOf: aString)
		  ifTrue: [ (context lookupVar: aString) asDoItVariableFrom: context ]
		  ifFalse: [ nil ]
]

{ #category : #accessing }
SpContextInteractionModel >> context [

	^context
]

{ #category : #accessing }
SpContextInteractionModel >> context: aContext [
	context := aContext
]

{ #category : #accessing }
SpContextInteractionModel >> doItContext [

	^ self context
]

{ #category : #accessing }
SpContextInteractionModel >> doItReceiver [

	^ self context receiver
]

{ #category : #testing }
SpContextInteractionModel >> hasBindingOf: aString [
	"we lookup the name without creating a new variable"
	^ (context lookupVar: aString declare: false) notNil
]

{ #category : #testing }
SpContextInteractionModel >> hasUnsavedCodeChanges [

	^ context notNil and: [ context sourceCode ~= owner text asString ]
]

{ #category : #testing }
SpContextInteractionModel >> isScripting [ 
	^context belongsToDoIt
]

{ #category : #accessing }
SpContextInteractionModel >> object [

	^ self doItReceiver
]
