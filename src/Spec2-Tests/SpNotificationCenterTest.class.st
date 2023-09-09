Class {
	#name : #SpNotificationCenterTest,
	#superclass : #TestCase,
	#category : #'Spec2-Tests-Notifications'
}

{ #category : #tests }
SpNotificationCenterTest >> testAddAnItemAddsIt [

	| f center |
	f := SpNotificationItem with: 'first'.
	center := SpNotificationCenter new.
	center add: f.
	self assert: center items first text equals: 'first'
]

{ #category : #tests }
SpNotificationCenterTest >> testItemsAreOrderedLIFO [

	| f center f2 |
	f := SpNotificationItem with: 'first'.
	center := SpNotificationCenter new.
	center add: f.
	f2  := SpNotificationItem with: 'second'.
	center add: f2.
	self assert: center items first text equals: 'second'
]
