"
I am a composable presenter that keeps reference to its domain model (announcingObject) optionally wrapped in a value holder and subscribes yourself to it. The model (announcingObject) can be instance of a subclass of Model, a value holder or a regular object.

The difference is that if an announcing object is given as model, it is stored directly into announcingObject. For regular objects, they got wrapped automatically in a value holder.

You should implement the method `modelChanged` in my subclasses.

"
Class {
	#name : 'SpPresenterWithModel',
	#superclass : 'SpPresenter',
	#instVars : [
		'announcingObject'
	],
	#category : 'Spec2-Core-Base',
	#package : 'Spec2-Core',
	#tag : 'Base'
}

{ #category : 'accessing - private' }
SpPresenterWithModel >> announcingObject [

	^ announcingObject
]

{ #category : 'accessing' }
SpPresenterWithModel >> model [

	 ^ self announcingObject value
]

{ #category : 'accessing' }
SpPresenterWithModel >> model: aDomainObject [
	"aDomainObject can be regular object, a value holder or an instance of Model"
	
	(aDomainObject isSpAnnouncingObject not and: [ self announcingObject isValueHolder ])
		ifTrue: [ self announcingObject value: aDomainObject ]
		ifFalse: [ self setAnnouncingObject: aDomainObject ]
	
]

{ #category : 'initialization' }
SpPresenterWithModel >> modelChanged [

	"subclass responsibility (optional)"
]

{ #category : 'accessing - private' }
SpPresenterWithModel >> setAnnouncingObject: aDomainObject [

	announcingObject := aDomainObject isSpAnnouncingObject ifFalse: [ aDomainObject asValueHolder ] ifTrue: [ aDomainObject ].
	announcingObject whenChangedDo: [ self modelChanged ].
	
]

{ #category : 'transmission' }
SpPresenterWithModel >> setModel: aDomainObject [

	^	self model: aDomainObject
]

{ #category : 'initialization' }
SpPresenterWithModel >> setModelBeforeInitialization: aDomainObject [

	self setAnnouncingObject: aDomainObject.

]

{ #category : 'updating' }
SpPresenterWithModel >> updatePresenter [

	self modelChanged 
]
