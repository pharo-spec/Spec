"
Description
--------------------

I am a demo page to show how to use progress bar.
"
Class {
	#name : #SpecProgressBarDemoPage,
	#superclass : #SpecDemoPage,
	#category : #'Spec-Examples-Demo-Loading'
}

{ #category : #initialization }
SpecProgressBarDemoPage class >> pageName [
	^ 'Progress bar'
]

{ #category : #initialization }
SpecProgressBarDemoPage >> pageClass [
	^ SpecProgressBarDemo
]
