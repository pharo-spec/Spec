Class {
	#name : #SpCodeBrowseInteractionModel,
	#superclass : #SpCodeInteractionModel,
	#instVars : [
		'method'
	],
	#category : #'Spec2-Code'
}

{ #category : #'instance creation' }
SpCodeBrowseInteractionModel class >> on: aMethod [

	^ self new method: aMethod
]

{ #category : #accessing }
SpCodeBrowseInteractionModel >> behavior [

	^ self method ifNotNil: [ self method methodClass ]
]

{ #category : #initialization }
SpCodeBrowseInteractionModel >> initialize [

	super initialize.
	self setBindings: Dictionary new
]

{ #category : #accessing }
SpCodeBrowseInteractionModel >> method [

	^ method
]

{ #category : #accessing }
SpCodeBrowseInteractionModel >> method: aMethod [

	method := aMethod
]
