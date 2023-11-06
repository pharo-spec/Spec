"
Description
--------------------

I am a page for a labelled presenter demo
"
Class {
	#name : 'SpDemoLabeledPage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-Labeled',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Labeled'
}

{ #category : 'initialization' }
SpDemoLabeledPage class >> pageName [

	^ 'Labeled presenter'
]

{ #category : 'initialization' }
SpDemoLabeledPage class >> priority [

	^ 1300
]

{ #category : 'initialization' }
SpDemoLabeledPage >> pageClass [
	^ SpDemoLabeledPresenter
]
