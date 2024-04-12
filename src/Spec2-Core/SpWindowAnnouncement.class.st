Class {
	#name : 'SpWindowAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'window'
	],
	#category : 'Spec2-Core-Windows',
	#package : 'Spec2-Core',
	#tag : 'Windows'
}

{ #category : 'accessing' }
SpWindowAnnouncement >> window [
	^ window
]

{ #category : 'accessing' }
SpWindowAnnouncement >> window: anObject [
	window := anObject
]
