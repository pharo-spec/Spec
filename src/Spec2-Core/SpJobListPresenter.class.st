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
	| jobList |
	
	jobList := self new.
	[ 
		1 to: 5 do: [ :index | 
		[
			jobList pushJob: (SpJob new 
				title: 'Job ', index asString;
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
		window resize: 500@((layout children size * self jobPresenterHeight) + 10) ]
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
SpJobListPresenter >> initialize [

	super initialize.
	self announcer
		when: JobStart send: #jobStart: to: self;
		when: JobChange send: #jobChanged: to: self;
		when: JobEnd send: #jobEnd: to: self
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

	^ 80
]

{ #category : 'private - events' }
SpJobListPresenter >> jobStart: ann [

	"Skip if already there"
	(self findJob: ann job) ifNotNil: [ :aJobPresenter | 
		aJobPresenter refresh.
		^ self ].
	self addJobPresenter: ann job.
	self ensureOpen
]

{ #category : 'private' }
SpJobListPresenter >> newJob [
	
	^ Job new
]

{ #category : 'api' }
SpJobListPresenter >> pushJob: aJob [

	aJob installOn: self.
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
	
	self withWindowDo: [ :window | 
		self layout children 
			ifNotEmpty: [ 
				window resize: 500@(layout children size * self jobPresenterHeight).
				window centered	 ]
			ifEmpty: [
				window close ] ]
]

{ #category : 'private' }
SpJobListPresenter >> resetLayout [
	
	self layout: SpBoxLayout newTopToBottom
]
