Class {
	#name : #SpCodeEvaluationFailedAnnouncement,
	#superclass : #SpCodeAnnouncement,
	#instVars : [
		'error'
	],
	#category : #'Spec2-Code-Announcements'
}

{ #category : #'instance creation' }
SpCodeEvaluationFailedAnnouncement class >> newContent: aString error: anError [

	^ self new 
		content: aString; 
		error: anError;
		yourself
]

{ #category : #accessing }
SpCodeEvaluationFailedAnnouncement >> error [

	^ error
]

{ #category : #accessing }
SpCodeEvaluationFailedAnnouncement >> error: anError [

	error := anError
]
