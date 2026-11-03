"
I am the demo page descriptor for SpPanedLayoutExamplePresenter in the Spec2 demo browser.
"
Class {
	#name : 'SpPanedLayoutExamplePage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-Layouts',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Layouts'
}

{ #category : 'initialization' }
SpPanedLayoutExamplePage class >> pageName [
	^ 'Paned Layouts'
]

{ #category : 'initialization' }
SpPanedLayoutExamplePage class >> priority [
	^ 2150
]

{ #category : 'initialization' }
SpPanedLayoutExamplePage >> pageClass [
	^ SpPanedLayoutExamplePresenter
]
