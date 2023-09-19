Class {
	#name : 'SpNotificationTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Tests-Notifications',
	#package : 'Spec2-Tests',
	#tag : 'Notifications'
}

{ #category : 'tests' }
SpNotificationTest >> testNotificationIsKeptAround [

	| pres app |
	app := SpApplication new.
	pres := SpPresenter newApplication: app. 
	pres notify: 'You should see this notification'.
	self 
		assert: app notificationCenter items first text 
		equals: 'You should see this notification'
]
