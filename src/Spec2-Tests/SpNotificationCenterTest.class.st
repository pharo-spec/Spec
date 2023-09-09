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
