Class {
	#name : #SpValueHolder,
	#superclass : #Object,
	#instVars : [
		'subscriptions',
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
	lock := false.
	subscriptions := OrderedCollection new
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

{ #category : #accessing }
SpValueHolder >> subscriptions [
	^ subscriptions
]

{ #category : #accessing }
SpValueHolder >> subscriptions: anObject [
	subscriptions := anObject
]

{ #category : #transfert }
SpValueHolder >> transferSubscriptionsTo: aSpValueHolder [
	aSpValueHolder subscriptions: subscriptions
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
	self valueChanged: nil
]

{ #category : #accessing }
SpValueHolder >> valueChanged: oldValue [
	subscriptions do: [ :block | block cull: self value cull: oldValue ]
]

{ #category : #enumerating }
SpValueHolder >> whenChangedDo: aBlock [
	subscriptions add: aBlock
]
