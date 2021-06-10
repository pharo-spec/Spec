"
Description
--------------------

I am a page for a labelled presenter demo
"
Class {
	#name : #SpDemoLabeledPage,
	#superclass : #SpDemoPage,
	#category : #'Spec2-Examples-Demo-Forms'
}

{ #category : #initialization }
SpDemoLabeledPage class >> pageName [

	^ 'Labeled presenter'
]

{ #category : #initialization }
SpDemoLabeledPage >> pageClass [
	^ SpDemoLabeledPresenter
]
