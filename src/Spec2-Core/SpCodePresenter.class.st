"
I'm a code (Pharo code) presenter. 
I will style and provide completion according to the behaviour being edited.
"
Class {
	#name : #SpCodePresenter,
	#superclass : #SpTextPresenter,
	#instVars : [
		'#doItContext => SpObservableSlot',
		'#doItReceiver => SpObservableSlot',
		'#behavior => SpObservableSlot',
		'#syntaxHighlight => SpObservableSlot',
		'#completionEngine => SpObservableSlot',
		'#interactionModel'
	],
	#category : #'Spec2-Core-Widgets-Text'
}

{ #category : #binding }
SpCodePresenter >> bindingOf: aString [

	^ interactionModel ifNotNil:  [ interactionModel bindingOf: aString  ]
]

{ #category : #binding }
SpCodePresenter >> doItContext [

	doItContext ifNotNil: [ ^ doItContext ].
	^ interactionModel ifNotNil: [ :im | im doItContext ]
]

{ #category : #binding }
SpCodePresenter >> doItContext: anObject [

	doItContext := anObject
]

{ #category : #binding }
SpCodePresenter >> doItReceiver [
	
	doItReceiver ifNotNil: [ 
		| receiver |
		receiver := doItReceiver.
		receiver isBehavior ifTrue: [ 
			receiver := receiver instanceSide ].
		^ receiver ].
	
	^ interactionModel ifNotNil: [ :im | im doItReceiver ]
]

{ #category : #binding }
SpCodePresenter >> doItReceiver: anObject [

	doItReceiver := anObject
]

{ #category : #binding }
SpCodePresenter >> hasBindingOf: aString [

	^ interactionModel 
		ifNotNil: [ :im | im hasBindingOf: aString ]
		ifNil: [ false ]
]

{ #category : #binding }
SpCodePresenter >> hasBindingThatBeginsWith: aString [ 
	
	^ interactionModel
		ifNotNil: [ :im | im hasBindingThatBeginsWith: aString ] 
		ifNil: [ false ]
]

{ #category : #api }
SpCodePresenter >> interactionModel [

	^ interactionModel
]

{ #category : #api }
SpCodePresenter >> interactionModel: anObject [ 	

	interactionModel := anObject
]

{ #category : #binding }
SpCodePresenter >> selectedClassOrMetaClass [

	behavior ifNotNil: [ ^ behavior ].
	^ interactionModel ifNotNil: [ :im | im selectedClassOrMetaClass ]
]
