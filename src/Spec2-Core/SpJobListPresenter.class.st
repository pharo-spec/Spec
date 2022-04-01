"
A presenter to stack jobs.
"
Class {
	#name : #SpJobListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'refreshRateInMs'
	],
	#category : #'Spec2-Core-Job'
}

{ #category : #examples }
SpJobListPresenter class >> example [ 
	| jobList |
	
	jobList := self new.
	[ 
		1 to: 5 do: [ :index | 
		[
			jobList pushJob: (SpJob 
				newTitle: 'Job ', index asString
				block: [ :job | 
					job min: 1; max: 10.
					1 to: 10 do: [ :i | 
						job title: ('Test {1}/10' format: {i}).
						job value: i. 
						250 milliSeconds wait ] ]).
		] fork.
		200 milliSeconds wait ]  
	] fork.

	^ nil
]

{ #category : #private }
SpJobListPresenter >> addJobPresenter: aJob [
	| presenter |
	
	presenter := self instantiate: SpJobPresenter on: aJob.
	presenter refreshRateInMs: refreshRateInMs.
	self layout add: presenter expand: false.
	
	self layout children size = 1 
		ifTrue: [ self open ].
	
	self withWindowDo: [ :window | 
		window resize: 500@(layout children size *  self jobPresenterHeight) ]
]

{ #category : #initialization }
SpJobListPresenter >> initializePresenters [

	self layout: SpBoxLayout newTopToBottom
]

{ #category : #initialization }
SpJobListPresenter >> initializeWindow: aWindowPresenter [ 

	aWindowPresenter 
		initialExtent: 500@(self jobPresenterHeight);
		withoutDecorations;
		beNotResizable;
		centered
]

{ #category : #private }
SpJobListPresenter >> jobPresenterHeight [

	^ 70
]

{ #category : #api }
SpJobListPresenter >> pushJob: aJob [

	aJob whenStartDo: [ :ann | self addJobPresenter: ann job ].
	aJob whenEndDo: [ :ann | self removeJobPresenter: ann job ]. 
	
	aJob run	
]

{ #category : #api }
SpJobListPresenter >> refreshRateInMs: anInteger [ 
	refreshRateInMs := anInteger.
]

{ #category : #private }
SpJobListPresenter >> removeJobPresenter: aJob [
	| presenter |
	
	presenter := self layout children detect: [ :each | each model = aJob ].
	self layout remove: presenter.
	
	self layout children  
		ifEmpty: [ self withWindowDo: [ :window | window close ] ].
	
	self withWindowDo: [ :window | 
		window resize: 500@(layout children size * self jobPresenterHeight).
		window centered ]
]
