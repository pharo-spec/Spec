"
I'm a base styte to be applied to widgets.
Styles are collected as part of a class, but they behave as a special kind of STON map.

My children may want to override #stonName to use a more elegant naming that just a class name.
"
Class {
	#name : #SpStyleProperty,
	#superclass : #SpStyle,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #copying }
SpStyleProperty >> , other [

	^ self mergeWith: other
]

{ #category : #operations }
SpStyleProperty >> applyTo: aMorph [
	
]

{ #category : #'instance creation' }
SpStyleProperty >> fromSton: stonReader [

	"I will use accessors because I want to be able to add convenience methods"
	stonReader parseMapDo: [ :message :value |
		self 
			perform: message asMutator 
			with: value ]
]

{ #category : #testing }
SpStyleProperty >> isStyleProperty [

	^ true
]

{ #category : #operations }
SpStyleProperty >> mergeWith: otherProperty [
	| merged |

	self species = otherProperty species ifFalse: [ 
		self error: 'Trying to merge two different properties' ].
 
	merged := self species new.
	self class allSlots do: [ :eachSlot | 
		"other property will have precedence over this one"
		merged 
			writeSlot: eachSlot 
			value: ((otherProperty readSlot: eachSlot) ifNil:[ self readSlot: eachSlot ]) ].
		
	^ merged
]
