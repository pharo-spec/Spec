"
Description
--------------------

Demo page for SpecDemoNotebookPresenter
"
Class {
	#name : #SpDemoNotebookPage,
	#superclass : #SpDemoPage,
	#category : #'Spec2-Examples-Demo-Notebook'
}

{ #category : #specs }
SpDemoNotebookPage class >> pageName [
	^ 'Notebook'
]

{ #category : #initialization }
SpDemoNotebookPage class >> priority [

	^ 1100
]

{ #category : #initialization }
SpDemoNotebookPage >> pageClass [
	^ SpDemoNotebookPresenter
]
