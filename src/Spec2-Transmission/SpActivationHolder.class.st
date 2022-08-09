"
A holder to allow activation (and selection) events to be listened by more than one object (otherwise, it can hold just one)
"
Class {
	#name : #SpActivationHolder,
	#superclass : #Object,
	#instVars : [
		'subscriptions'
	],
	#category : #'Spec2-Transmission-Custom'
}

{ #category : #adding }
SpActivationHolder >> add: aBlock [

	subscriptions := subscriptions copyWith: aBlock
]

{ #category : #evaluating }
SpActivationHolder >> cull: arg [

	subscriptions do: [ :each | 
		each cull: arg ]
]

{ #category : #evaluating }
SpActivationHolder >> cull: firstArg cull: secondArg [

	subscriptions do: [ :each | 
		each cull: firstArg cull: secondArg ]
]

{ #category : #evaluating }
SpActivationHolder >> cull: firstArg cull: secondArg cull: thirdArg [

	subscriptions do: [ :each | 
		each cull: firstArg cull: secondArg cull: thirdArg ]
]

{ #category : #initialization }
SpActivationHolder >> initialize [

	super initialize.
	subscriptions := #()
]

{ #category : #evaluating }
SpActivationHolder >> value: arg [

	subscriptions do: [ :each | 
		each value: arg ]
]

{ #category : #evaluating }
SpActivationHolder >> value: firstArg value: secondArg [

	subscriptions do: [ :each | 
		each value: firstArg value: secondArg ]
]

{ #category : #evaluating }
SpActivationHolder >> value: firstArg value: secondArg value: thirdArg [

	subscriptions do: [ :each | 
		each value: firstArg value: secondArg value: thirdArg ]
]
