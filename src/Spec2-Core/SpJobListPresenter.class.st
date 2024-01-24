"
A presenter to stack jobs.
"
Class {
	#name : 'SpJobListPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'refreshRateInMs'
	],
	#category : 'Spec2-Core-Job',
	#package : 'Spec2-Core',
	#tag : 'Job'
}

{ #category : 'examples' }
SpJobListPresenter class >> example [ 

	[ 
		1 to: 5 do: [ :index | 
		[
			Job new 
				title: 'Job ', index asString;
				block: [ :job | 
					job min: 1; max: 10.
					1 to: 10 do: [ :i | 
						job title: ('Test {1}/10' format: {i}).
						job value: i. 
						250 milliSeconds wait ] ];
				run.
		] fork.
		200 milliSeconds wait ]  
	] fork.

	^ nil
]

{ #category : 'private' }
SpJobListPresenter >> addJobPresenter: aJob [
	| presenter |
	
	aJob title ifEmpty: [ aJob title: 'Processing...' ].
	
	presenter := self instantiate: SpJobPresenter on: aJob.
	presenter refreshRateInMs: refreshRateInMs.
	self layout add: presenter expand: false.
	
	self layout children size = 1 
		ifTrue: [ self open ].
	
	self withWindowDo: [ :window | 
		window resize: 500@((layout children size * self jobPresenterHeight) + 20) ]
]

{ #category : 'private' }
SpJobListPresenter >> ensureOpen [
	
	self withWindowDo: [ :aWindow |
		aWindow isOpen 
			ifFalse: [ self open ] ]
]

{ #category : 'private' }
SpJobListPresenter >> findJob: aJob [
	
	^ self layout children 
		detect: [ :each | each model = aJob ]
		ifNone: [ nil ]
]

{ #category : 'initialization' }
SpJobListPresenter >> initializePresenters [

	self layout: SpBoxLayout newTopToBottom
]

{ #category : 'initialization' }
SpJobListPresenter >> initializeWindow: aWindowPresenter [ 

	aWindowPresenter 
		initialExtent: 500@(self jobPresenterHeight);
		withoutDecorations;
		beNotResizable;
		centered
]

{ #category : 'testing' }
SpJobListPresenter >> isEmpty [
	
	^ self layout children isEmpty
]

{ #category : 'private - events' }
SpJobListPresenter >> jobChanged: ann [

	(self findJob: ann job) ifNotNil: [ :aPresenter | 
		aPresenter model title crTrace.
		aPresenter updatePresenter ]
]

{ #category : 'private - events' }
SpJobListPresenter >> jobEnd: ann [
	
	self removeJobPresenter: ann job
]

{ #category : 'private' }
SpJobListPresenter >> jobPresenterHeight [

	^ 70
]

{ #category : 'private - events' }
SpJobListPresenter >> jobStart: ann [

	"Skip if already there"
	(self findJob: ann job) ifNotNil: [ ^ self ].
	self addJobPresenter: ann job.
	self ensureOpen
]

{ #category : 'private' }
SpJobListPresenter >> newJob [
	
	^ Job new
]

{ #category : 'api' }
SpJobListPresenter >> pushJob: aJob [

	aJob run
]

{ #category : 'api' }
SpJobListPresenter >> pushJobWith: aBlock [
	| job |
	
	job := self newJob.
	job block: aBlock.
	self pushJob: job
]

{ #category : 'api' }
SpJobListPresenter >> refreshRateInMs: anInteger [ 

	refreshRateInMs := anInteger
]

{ #category : 'private' }
SpJobListPresenter >> removeJobPresenter: aJob [
	| presenter |
	
	presenter := self findJob: aJob.
	presenter ifNil: [ ^ self ].
	
	self layout remove: presenter.
	
	self layout children  
		ifEmpty: [ self withWindowDo: [ :window | window close ] ].
	
	self withWindowDo: [ :window | 
		window resize: 500@(layout children size * self jobPresenterHeight).
		window centered ]
]
