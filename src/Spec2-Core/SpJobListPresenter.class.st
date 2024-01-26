"
A presenter to stack jobs.
"
Class {
	#name : 'SpJobListPresenter',
	#superclass : 'SpPresenter',
	#classTraits : '{} + TraitedClass',
	#instVars : [
		'refreshRateInMs',
		'mutex',
		'jobs'
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
	
	jobs at: aJob put: presenter.
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
	
	^ jobs 
		at: aJob 
		ifAbsent: [ nil ]
]

{ #category : 'initialization' }
SpJobListPresenter >> initialize [

	super initialize.
	jobs := SmallDictionary new.
	mutex := Mutex new.
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

	mutex critical: [ 
		(self findJob: ann job) 
			ifNotNil: [ :aPresenter | aPresenter updatePresenter ] ]
]

{ #category : 'private - events' }
SpJobListPresenter >> jobEnd: ann [
	
	mutex critical: [ 
		self removeJobPresenter: ann job ]
]

{ #category : 'private' }
SpJobListPresenter >> jobPresenterHeight [

	^ 80
]

{ #category : 'private - events' }
SpJobListPresenter >> jobStart: ann [

	"Skip if already there"
	mutex critical: [ 
		(self findJob: ann job) ifNotNil: [ :aJobPresenter | 
			aJobPresenter refresh.
			^ self ].
		self addJobPresenter: ann job ].

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
	
	jobs removeKey: aJob.
	self layout remove: presenter.

	self withWindowDo: [ :window | 
		self layout children 
			ifNotEmpty: [ 
				window resize: 500@(layout children size * self jobPresenterHeight).
				window centered	 ]
			ifEmpty: [
				window close.
				self flag: #HACK. "This is a hack to prevent a leak that I cannot 
				detect while executing this several times. Removing the job list 
				from the application will effectively clean up the process (but 
				the leak is still there, somewhere in morphic...I need to find it)"
				self application removeProperty: #jobList ] ]
]

{ #category : 'private' }
SpJobListPresenter >> resetLayout [
	
	self layout: SpBoxLayout newTopToBottom
]
