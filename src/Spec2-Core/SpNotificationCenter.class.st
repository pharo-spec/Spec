"
I'm a simple object holding a limited list of notification items.
"
Class {
	#name : #SpNotificationCenter,
	#superclass : #Object,
	#instVars : [
		'items',
		'limit'
	],
	#category : #'Spec2-Core-Notification'
}

{ #category : #adding }
SpNotificationCenter >> add: aSpNotificationItem [ 
	items size > limit
		ifTrue: [ items removeLast: self bulkSize ].
	items addFirst: aSpNotificationItem
]

{ #category : #adding }
SpNotificationCenter >> bulkSize [
	"Returns the number of itesm that should be removed when the limit is reached.
	Pay attention that the limit MUST always be larger than bulkSize"
	
	^ 5
]

{ #category : #initialization }
SpNotificationCenter >> initialize [

	super initialize.
	"Pay attention limit must not smaller than bulkSize because else
	we will try to remove more elements than the number we have."
	limit := 30.
	items := OrderedCollection new.
]

{ #category : #accessing }
SpNotificationCenter >> items [
	^ items
]

{ #category : #accessing }
SpNotificationCenter >> limit [
	^ limit
]
