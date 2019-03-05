"
I'm a weak value holder. 
I keep a weak reference to the instance in contents.
"
Class {
	#name : #WeakValueHolder,
	#superclass : #Object,
	#type : #weak,
	#category : #'Spec-Core-Base'
}

{ #category : #'instance creation' }
WeakValueHolder class >> contents: anObject [
	^ self new contents: anObject
]

{ #category : #'instance creation' }
WeakValueHolder class >> new [
	^ (self basicNew: 1) initialize
]

{ #category : #accessing }
WeakValueHolder >> contents [
	^ self basicAt: 1
]

{ #category : #accessing }
WeakValueHolder >> contents: anObject [
	self basicAt: 1 put: anObject
]
