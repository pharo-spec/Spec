"
A collection model to be used with list presenters (`SpAbstractListPresenter` and children).

This model receives a `collection` of elements to be served to the list.
"
Class {
	#name : #SpCollectionListModel,
	#superclass : #Object,
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#announcer',
		'#collection',
		'#sorting => ObservableSlot'
	],
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #'instance creation' }
SpCollectionListModel class >> on: aCollection [
	
	^ self new
		collection: aCollection;
		yourself
]

{ #category : #adding }
SpCollectionListModel >> add: anItem [
	
	collection := collection copyWith: anItem.
	
	self refreshList.
	self announcer announce: (ValueChanged newValue: self)
	
]

{ #category : #accessing }
SpCollectionListModel >> announcer [ 

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
SpCollectionListModel >> at: anIndex [

	^ collection at: anIndex
]

{ #category : #accessing }
SpCollectionListModel >> at: anIndex ifAbsent: aBlock [

	^ collection at: anIndex ifAbsent: aBlock
]

{ #category : #accessing }
SpCollectionListModel >> collection [
	^ collection
]

{ #category : #accessing }
SpCollectionListModel >> collection: anObject [
	| oldValue |

	oldValue := collection.
	collection := anObject.
	self refreshList.
	
	self announcer announce: (ValueChanged 
		oldValue: oldValue 
		newValue: collection)
]

{ #category : #testing }
SpCollectionListModel >> hasElementAt: index [

	^ self size >= index
]

{ #category : #accessing }
SpCollectionListModel >> indexOf: anIndex ifAbsent: aBlock [

	^ collection indexOf: anIndex ifAbsent: aBlock
]

{ #category : #initialization }
SpCollectionListModel >> initialize [
	self class initializeSlots: self.
	super initialize
]

{ #category : #testing }
SpCollectionListModel >> isEmpty [

	^ collection isEmpty
]

{ #category : #accessing }
SpCollectionListModel >> items [

	^ collection
]

{ #category : #refreshing }
SpCollectionListModel >> refreshList [

	self sortingBlock ifNotNil: [ :aSortFunction | collection := collection sorted: aSortFunction ]
]

{ #category : #collection }
SpCollectionListModel >> removeAll [
	
	collection := #().
	
	self refreshList.
	self announcer announce: (ValueChanged newValue: self)
		
]

{ #category : #accessing }
SpCollectionListModel >> size [

	^ collection size
]

{ #category : #initialization }
SpCollectionListModel >> sortingBlock [
	^ sorting
]

{ #category : #initialization }
SpCollectionListModel >> sortingBlock: aBlock [
	sorting := aBlock.
	self refreshList
]

{ #category : #events }
SpCollectionListModel >> whenChangedDo: aBlock [
	
	self announcer 
		when: ValueChanged 
		do: [ :ann |
			aBlock 
				cull: ann newValue 
				cull: ann oldValue
				cull: ann ]
		for: self
]

{ #category : #events }
SpCollectionListModel >> whenSortingBlockChangedDo: aBlock [

	self property: #sorting whenChangedDo: aBlock
]
