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
SpNotificationCenterTest >> testAddingOverTheLimitCutFirst [

	| f center |
	center := SpNotificationCenter new.
	1 to: 35 do: [ :each | 
		f := SpNotificationItem with: each printString.
		center add: f ] .

	self assert: center items size equals: center limit
]

{ #category : #tests }
SpNotificationCenterTest >> testAddingOverTheLimitRemoveBuldElements [

	| f center |
	center := SpNotificationCenter new.
	1 to: 32 do: [ :each | 
		f := SpNotificationItem with: each printString.
		center add: f ] .

	"when we added 31 we removed buld elements (5)  and added 31 and 32 so we have 27 elements"
	self assert: center items size equals: center limit - center bulkSize + (32 - center limit)
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
