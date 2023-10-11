"
Description
--------------------

Demo page for SpecDemoImagePresenter
"
Class {
	#name : 'SpDemoImagePage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-Other',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Other'
}

{ #category : 'initialization' }
SpDemoImagePage class >> pageName [

	^ 'Images'
]

{ #category : 'initialization' }
SpDemoImagePage class >> priority [

	^ 1600
]

{ #category : 'initialization' }
SpDemoImagePage >> pageClass [

	^ SpDemoImagePresenter
]
