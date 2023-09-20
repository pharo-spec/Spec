Class {
	#name : 'SpNotebookPageChanged',
	#superclass : 'SpNotebookPageAnnouncement',
	#instVars : [
		'oldPage'
	],
	#category : 'Spec2-Adapters-Morphic-Notebook',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Notebook'
}

{ #category : 'accessing' }
SpNotebookPageChanged >> oldPage [
	^ oldPage
]

{ #category : 'accessing' }
SpNotebookPageChanged >> oldPage: anObject [
	oldPage := anObject
]
