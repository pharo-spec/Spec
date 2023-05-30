Class {
	#name : #SpCodeScriptingInteractionModel,
	#superclass : #SpCodeInteractionModel,
	#instVars : [
		'bindings'
	],
	#category : #'Spec2-Code-Base'
}

{ #category : #accessing }
SpCodeScriptingInteractionModel >> addBinding: aBinding [

	self bindings add: aBinding
]

{ #category : #binding }
SpCodeScriptingInteractionModel >> bindingOf: aString [

	"if there is no binding, I will include a key"
	(self bindings includesKey: aString)
		ifFalse: [ self addBinding: (WorkspaceVariable key: aString asSymbol) ].
	^ self bindings associationAt: aString
]

{ #category : #accessing }
SpCodeScriptingInteractionModel >> bindings [

	^ bindings ifNil: [ bindings := Dictionary new ]
]

{ #category : #testing }
SpCodeScriptingInteractionModel >> canAddBindingOf: name [

	"Check is a special variable named `name` can be declared but without declaring it."
	^ name first isUppercase not and: [ name startsWithDigit not ]

]

{ #category : #testing }
SpCodeScriptingInteractionModel >> hasBindingOf: aString [

	^ self bindings includesKey: aString asSymbol
]

{ #category : #testing }
SpCodeScriptingInteractionModel >> isScripting [

	^ true
]

{ #category : #testing }
SpCodeScriptingInteractionModel >> needRequestorScope [
	^true
]

{ #category : #accessing }
SpCodeScriptingInteractionModel >> removeAllBindings [
 
	self bindings removeAll
]

{ #category : #accessing }
SpCodeScriptingInteractionModel >> removeBinding: aBinding [
 
	self bindings removeKey: aBinding key
]

{ #category : #accessing }
SpCodeScriptingInteractionModel >> variableBindings [

	^ self bindings
]
