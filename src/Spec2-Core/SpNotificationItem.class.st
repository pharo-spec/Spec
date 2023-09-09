"
I'm a simple object representing a notification.
"
Class {
	#name : #SpNotificationItem,
	#superclass : #Object,
	#instVars : [
		'text'
	],
	#category : #'Spec2-Core-Notification'
}

{ #category : #'instance creation' }
SpNotificationItem class >> with: aString [

	^ self new text: aString ; yourself
]

{ #category : #accessing }
SpNotificationItem >> text [
	^ text
]

{ #category : #accessing }
SpNotificationItem >> text: aString [ 
	text := aString
]
