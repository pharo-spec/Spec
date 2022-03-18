"
I am a demo page for the spec examples demo app to exemplify the use of SpScrollablePresenters
"
Class {
	#name : #SpScrollableLayoutExamplePage,
	#superclass : #SpDemoPage,
	#category : #'Spec2-Examples-Demo-Layouts'
}

{ #category : #initialization }
SpScrollableLayoutExamplePage class >> pageName [

	^'Scrollable layout'

]

{ #category : #initialization }
SpScrollableLayoutExamplePage class >> priority [

	^ 2100
]

{ #category : #initialization }
SpScrollableLayoutExamplePage >> pageClass [

	^SpScrollableLayoutExamplePresenter 

]
