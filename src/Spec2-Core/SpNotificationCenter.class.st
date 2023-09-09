"
I'm a simple object holding a limited list of notification items.
"
Class {
	#name : #SpNotificationCenter,
	#superclass : #Object,
	#instVars : [
		'items',
		'limit',
		'application'
	],
	#category : #'Spec2-Core-Notification'
}

{ #category : #adding }
SpNotificationCenter >> add: aSpNotificationItem [ 
	items size > limit
		ifTrue: [ items removeLast: self bulkSize ].
	items addFirst: aSpNotificationItem.
	self updateIfNecessary.
]

{ #category : #accessing }
SpNotificationCenter >> application [
	^ application
]

{ #category : #adding }
SpNotificationCenter >> bulkSize [
	"Returns the number of itesm that should be removed when the limit is reached.
	Pay attention that the limit MUST always be larger than bulkSize"
	
	^ 5
]

{ #category : #adding }
SpNotificationCenter >> forApplication: app [

	application := app
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

{ #category : #adding }
SpNotificationCenter >> updateIfNecessary [

	| notifs |
	notifs := self application windows select: [ :each | each title = 'Notifications' ].
	notifs do: [ :each | each updatePresenter ]
]
