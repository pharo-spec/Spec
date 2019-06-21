"
I am a composable presenter that  keeps reference to its domain model (announcingObject) optionally wrapped in a value holder and subscribes yourself to it.

As the model (announcingObject) we can set a subclass of Model or a value holder (NewValueHolder). In that case such models are stored directly into announcingObject.

You should implement the method #modelChanged in my subclasses

"
Class {
	#name : #SpComposablePresenterWithModel,
	#superclass : #SpComposablePresenter,
	#instVars : [
		'announcingObject'
	],
	#category : #'Spec-Core-Base'
}

{ #category : #'accessing - private' }
SpComposablePresenterWithModel >> announcingObject [

	^ announcingObject
]

{ #category : #accessing }
SpComposablePresenterWithModel >> model [

	 ^ self announcingObject value
]

{ #category : #accessing }
SpComposablePresenterWithModel >> model: aDomainObject [

	"aDomainObject can be regular object, a value holder (NewValueHolder) or an instance of Model"
	
	(aDomainObject isAnnouncingObject not and: [ self announcingObject isValueHolder ])
		ifTrue: [ self announcingObject value: aDomainObject ]
		ifFalse: [ self setAnnouncingObject: aDomainObject ]
	
]

{ #category : #initialization }
SpComposablePresenterWithModel >> modelChanged [

	"subclass responsibility (optional)"
]

{ #category : #'accessing - private' }
SpComposablePresenterWithModel >> setAnnouncingObject: aDomainObject [

	announcingObject := aDomainObject wrappedInValueHolderIfNeeded.
	announcingObject whenChangedDo: [ self modelChanged ].
	
]

{ #category : #initialization }
SpComposablePresenterWithModel >> setModelBeforeInitialization: aDomainObject [

	self setAnnouncingObject: aDomainObject.

]

{ #category : #updating }
SpComposablePresenterWithModel >> updatePresenter [

	self modelChanged 
]
