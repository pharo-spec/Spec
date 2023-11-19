"
Description
--------------------

Demo page for SpecDemoLinksPresenter
"
Class {
	#name : 'SpDemoLinksPage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-Other',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Other'
}

{ #category : 'specs' }
SpDemoLinksPage class >> pageName [

	^ 'Links'
]

{ #category : 'initialization' }
SpDemoLinksPage class >> priority [

	^ 1500
]

{ #category : 'initialization' }
SpDemoLinksPage >> pageClass [

	^ SpDemoLinksPresenter
]
