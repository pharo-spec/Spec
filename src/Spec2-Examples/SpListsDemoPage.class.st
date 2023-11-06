"
Description
--------------------

I am a demo page to show how to use spec lists.
"
Class {
	#name : 'SpListsDemoPage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-Lists',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Lists'
}

{ #category : 'initialization' }
SpListsDemoPage class >> pageName [
	^ 'Lists'
]

{ #category : 'initialization' }
SpListsDemoPage class >> priority [

	^ 400
]

{ #category : 'initialization' }
SpListsDemoPage >> pageClass [
	^ SpDemoListsPresenter
]
