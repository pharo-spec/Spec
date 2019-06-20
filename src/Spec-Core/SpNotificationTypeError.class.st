"
I'm a notification type error
"
Class {
	#name : #SpNotificationTypeError,
	#superclass : #SpNotificationType,
	#category : #'Spec-Core-Base'
}

{ #category : #dispatching }
SpNotificationTypeError >> notify: aSpecNotification on: aNotificationAware [
	
	aNotificationAware notifyError: aSpecNotification
]
