"
Description
--------------------

Demo page for SpecDemoNotebookPresenter
"
Class {
	#name : #SpDemoNotebookPage,
	#superclass : #SpDemoPage,
	#category : #'Spec-Examples-Demo-Other'
}

{ #category : #specs }
SpDemoNotebookPage class >> pageName [
	^ 'Notebook'
]

{ #category : #specs }
SpDemoNotebookPage class >> priority [
	^ 13
]

{ #category : #initialization }
SpDemoNotebookPage >> pageClass [
	^ SpDemoNotebookPresenter
]
