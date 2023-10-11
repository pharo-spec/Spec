"
Description
--------------------

Demo page for SpecDemoModalPresenter
"
Class {
	#name : 'SpDemoModalsPage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-Modals',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Modals'
}

{ #category : 'specs' }
SpDemoModalsPage class >> pageName [

	^ 'Modals'
]

{ #category : 'initialization' }
SpDemoModalsPage class >> priority [

	^ 1700
]

{ #category : 'initialization' }
SpDemoModalsPage >> pageClass [

	^ SpDemoModalPresenter

]
