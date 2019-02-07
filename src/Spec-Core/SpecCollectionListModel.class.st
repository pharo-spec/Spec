Class {
	#name : #SpecCollectionListModel,
	#superclass : #Object,
	#instVars : [
		'collection',
		'filter',
		'shownCollection',
		'changedBlock'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #'instance creation' }
SpecCollectionListModel class >> on: aCollection [
	
	^ self new
		collection: aCollection;
		yourself
]

{ #category : #accessing }
SpecCollectionListModel >> at: anIndex [

	^ collection at: anIndex
]

{ #category : #accessing }
SpecCollectionListModel >> at: anIndex ifAbsent: aBlock [

	^ collection at: anIndex ifAbsent: aBlock
]

{ #category : #accessing }
SpecCollectionListModel >> collection [
	^ collection
]

{ #category : #accessing }
SpecCollectionListModel >> collection: anObject [
	collection := anObject.
	self refreshList
]

{ #category : #accessing }
SpecCollectionListModel >> filterWith: aBlockClosure [ 
	
	filter := aBlockClosure.
	self refreshList.
]

{ #category : #accessing }
SpecCollectionListModel >> indexOf: anIndex ifAbsent: aBlock [

	^ collection indexOf: anIndex ifAbsent: aBlock
]

{ #category : #accessing }
SpecCollectionListModel >> initialize [

	super initialize.
	filter := [ true ]
]

{ #category : #accessing }
SpecCollectionListModel >> items [

	^ collection
]

{ #category : #refreshing }
SpecCollectionListModel >> refreshList [
	
	shownCollection := collection select: [ :elem | filter cull: elem cull: collection ].
]

{ #category : #accessing }
SpecCollectionListModel >> shownItems [
	
	^ shownCollection
]

{ #category : #accessing }
SpecCollectionListModel >> size [

	^ collection size
]

{ #category : #events }
SpecCollectionListModel >> whenChangedDo: aBlockClosure [ 
	
	changedBlock := aBlockClosure
]
