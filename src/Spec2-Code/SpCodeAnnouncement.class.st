Class {
	#name : #SpCodeAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'content'
	],
	#category : #'Spec2-Code-Announcements'
}

{ #category : #'instance creation' }
SpCodeAnnouncement class >> newContent: aString [

	^ self new
		content: aString;
		yourself
]

{ #category : #accessing }
SpCodeAnnouncement >> content [

	^ content
]

{ #category : #accessing }
SpCodeAnnouncement >> content: anObject [

	content := anObject
]
