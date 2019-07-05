Class {
	#name : #SpValueHolder,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'lock',
		'value'
	],
	#category : #'Spec2-Core-Observable'
}

{ #category : #'instance creation' }
SpValueHolder class >> value: contents [

	^ self new
		rawValue: contents;
		yourself
]

{ #category : #accessing }
SpValueHolder >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #transfert }
SpValueHolder >> getSubscriptionsFromSpValueHolder: aSpValueHolder [
	aSpValueHolder announcer subscriptions subscriptions do: [ :sub | self announcer basicSubscribe: sub ]
]

{ #category : #transfert }
SpValueHolder >> getSubscriptionsFromValueHolder: aCollectionValueHolder [
	self flag: #todo.	"This can be removed once NewValueHolder will not be used in multiple list selection anymore."

	aCollectionValueHolder announcer subscriptions subscriptions do: [ :sub | self announcer basicSubscribe: sub ]
]

{ #category : #private }
SpValueHolder >> handleCircularReferencesWhile: aBlock [
	"Used to handle circular references as explained in the class comment"

	lock ifTrue: [ ^ self ].
	lock := true.
	
	aBlock ensure: [ lock := false ].
]

{ #category : #initialization }
SpValueHolder >> initialize [
	super initialize.

	lock := false
]

{ #category : #printing }
SpValueHolder >> printOn: aStream [
	super printOn: aStream.
	
	aStream 
		nextPutAll: '[ '; 
		print: self value;
		nextPutAll: ' ]'
]

{ #category : #accessing }
SpValueHolder >> rawValue: aValue [
	value := aValue
]

{ #category : #evaluating }
SpValueHolder >> value [
	^ value
]

{ #category : #accessing }
SpValueHolder >> value: anObject [
	self
		handleCircularReferencesWhile: [ | oldValue |
			oldValue := value.
			value := anObject.
			self valueChanged: oldValue ]
]

{ #category : #accessing }
SpValueHolder >> valueChanged [
	self announcer announce: (ValueChanged newValue: self value)
]

{ #category : #accessing }
SpValueHolder >> valueChanged: oldValue [
	self announcer announce: (ValueChanged oldValue: oldValue newValue: self value)
]

{ #category : #enumerating }
SpValueHolder >> whenChangedDo: aBlock [
	| block |
	block := [ :announcement :ann | 
	aBlock
		cull: announcement newValue
		cull: announcement oldValue
		cull: announcement
		cull: ann ].
	self announcer when: ValueChanged do: block
]
