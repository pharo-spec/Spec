"
Description
--------------------

I am a demo page to show how to use progress bar.
"
Class {
	#name : 'SpProgressBarDemoPage',
	#superclass : 'SpDemoPage',
	#category : 'Spec2-Examples-Demo-Loading',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Loading'
}

{ #category : 'initialization' }
SpProgressBarDemoPage class >> pageName [
	^ 'Progress bar'
]

{ #category : 'initialization' }
SpProgressBarDemoPage class >> priority [

	^ 1400
]

{ #category : 'initialization' }
SpProgressBarDemoPage >> pageClass [
	^ SpProgressBarDemo
]
