Class {
	#name : #SpNotebookPageChanged,
	#superclass : #SpNotebookPageAnnouncement,
	#instVars : [
		'oldPage'
	],
	#category : #'Spec-MorphicAdapters-Notebook'
}

{ #category : #accessing }
SpNotebookPageChanged >> oldPage [
	^ oldPage
]

{ #category : #accessing }
SpNotebookPageChanged >> oldPage: anObject [
	oldPage := anObject
]
