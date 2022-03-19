"
A demo for progress bar usage

   self example
"
Class {
	#name : #SpProgressBarDemo,
	#superclass : #SpPresenter,
	#instVars : [
		'indeterminated',
		'fixed',
		'withProgressionBlock',
		'withText'
	],
	#category : #'Spec2-Examples-Demo-Loading'
}

{ #category : #examples }
SpProgressBarDemo class >> example [
	<sampleInstance>
	
	^ self new open
]

{ #category : #layout }
SpProgressBarDemo >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		  add: 'Indeterminated';
		  add: indeterminated;
		  add: 'Fixed';
		  add: fixed;
		  add: 'With progression block';
		  add: withProgressionBlock;
		  add: 'With text';
		  add: withText;
		  yourself
]

{ #category : #initialization }
SpProgressBarDemo >> initializePresenters [

	| progress progress2 |
	indeterminated := self newProgressBar.
	indeterminated indeterminate.
	
	fixed := self newProgressBar.
	fixed fixedPercentage: 30.

	withProgressionBlock := self newProgressBar.
	progress := 0.
	withProgressionBlock
		progress: [ progress := progress + 0.01 ]
		every: 0.5 second.

	withText := self newProgressBar.
	progress2 := 0.
	withText
		progress: [ progress2 := progress2 + 0.01 ]
		every: 1 second
]

{ #category : #'option list presenter' }
SpProgressBarDemo >> optionIcon [

	^ self iconNamed: #image
]

{ #category : #'option list presenter' }
SpProgressBarDemo >> optionTitle [

	^ 'Progress bar Presenter'
]
