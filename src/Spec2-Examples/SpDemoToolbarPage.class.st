"
Demo page for SpecDemoToolBarPresenter
"
Class {
	#name : 'SpDemoToolbarPage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-Buttons',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Buttons'
}

{ #category : 'specs' }
SpDemoToolbarPage class >> pageName [

	^ 'Toolbar'
]

{ #category : 'initialization' }
SpDemoToolbarPage class >> priority [

	^ 700
]

{ #category : 'initialization' }
SpDemoToolbarPage >> pageClass [

	^ SpDemoToolbarPresenter
]
