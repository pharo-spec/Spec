Class {
	#name : #NotebookPage,
	#superclass : #Object,
	#instVars : [
		'title',
		'icon',
		'presenter'
	],
	#category : #'Spec-Core-Widgets-Tab'
}

{ #category : #'instance creation' }
NotebookPage class >> title: aString presenter: aPresenter [

	^ self new 
		title: aString;
		presenter: aPresenter;
		yourself
]

{ #category : #accessing }
NotebookPage >> icon [
	^ icon
]

{ #category : #accessing }
NotebookPage >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
NotebookPage >> presenter [
	^ presenter
]

{ #category : #accessing }
NotebookPage >> presenter: anObject [
	presenter := anObject
]

{ #category : #accessing }
NotebookPage >> title [
	^ title
]

{ #category : #accessing }
NotebookPage >> title: anObject [
	title := anObject
]
