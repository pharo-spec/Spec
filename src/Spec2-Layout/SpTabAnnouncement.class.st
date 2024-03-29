Class {
	#name : 'SpTabAnnouncement',
	#superclass : 'Announcement',
	#instVars : [
		'presenter'
	],
	#category : 'Spec2-Layout-Tab',
	#package : 'Spec2-Layout',
	#tag : 'Tab'
}

{ #category : 'instance creation' }
SpTabAnnouncement class >> newPresenter: aPresenter [

	^ self new
		presenter: aPresenter;
		yourself
]

{ #category : 'accessing' }
SpTabAnnouncement >> presenter [

	^ presenter
]

{ #category : 'accessing' }
SpTabAnnouncement >> presenter: anObject [

	presenter := anObject
]
