"
A Job is a task to run and potentially notified to the user.
It is tipically used by a `SpJobPresenter` to display its progress.

By default, a progress state is a value between 0 and 1.

```
job := self newBlock: [ :job | 
	job title: 'Let us get started'.
	1 to: 10 do: [:each |
		job
			progress: (0.1 * each);
			title: 'Youpi ', each printString.
		(Delay forMilliseconds: 100) wait.
		] ]
job run.
```

See `SpJobPresenter` for a graphical example.
"
Class {
	#name : 'SpJob',
	#superclass : 'Object',
	#instVars : [
		'block',
		'currentValue',
		'min',
		'max',
		'title',
		'children',
		'isRunning',
		'parent',
		'process',
		'announcer'
	],
	#category : 'Spec2-Core-Job',
	#package : 'Spec2-Core',
	#tag : 'Job'
}

{ #category : 'accessing' }
SpJob class >> current [
	"Answer the current job or nil if none."

	^ CurrentJob value
]

{ #category : 'instance creation' }
SpJob class >> empty [

	^ self new 
		title: 'Unknown';
		block: [ :job| ];
		yourself
]

{ #category : 'instance creation' }
SpJob class >> newBlock: aBlock [

	^ self new
		block: aBlock;
		yourself
]

{ #category : 'instance creation' }
SpJob class >> newTitle: aString block: aBlock [ 

	^ self new 
		title: aString;
		block: aBlock;
		yourself
]

{ #category : 'private' }
SpJob >> addChild: aJob [

	children add: aJob.
	aJob parent: self
]

{ #category : 'accessing' }
SpJob >> announce: anAnnouncementClass [

	| announcement |
	announcement := anAnnouncementClass on: self.
	self announcer announce: announcement
]

{ #category : 'private' }
SpJob >> announceChange [

	isRunning ifFalse: [ ^ self ].
	self announce: JobChange
]

{ #category : 'accessing' }
SpJob >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : 'accessing' }
SpJob >> block [
	
	^ block
]

{ #category : 'private' }
SpJob >> block: aBlock [
	
	block := aBlock
]

{ #category : 'accessing' }
SpJob >> children [

	^ children copy
]

{ #category : 'private' }
SpJob >> cleanupAfterRunning [

	isRunning := false.
	process := nil.
	self announce: JobEnd.
	parent ifNotNil: [ :job | job removeChild: self ]
]

{ #category : 'compatibility' }
SpJob >> current [

	^ self currentValue
]

{ #category : 'compatibility' }
SpJob >> current: aNumber [

	self currentValue: aNumber
]

{ #category : 'accessing' }
SpJob >> currentValue [
	
	^ currentValue
]

{ #category : 'accessing' }
SpJob >> currentValue: aNumber [
	
	currentValue := aNumber.
	self announceChange
]

{ #category : 'compatibility' }
SpJob >> decrement [

	self currentValue: self currentValue - 1
]

{ #category : 'compatibility' }
SpJob >> increment [

	self currentValue: self currentValue + 1
]

{ #category : 'initialization' }
SpJob >> initialize [

	super initialize.
	min := 0.
	max := 100.
	currentValue := 0.
	title := ''.
	isRunning := false.
	children := OrderedCollection new
]

{ #category : 'testing' }
SpJob >> isRunning [

	^ isRunning
]

{ #category : 'compatibility' }
SpJob >> label [

	^ self title
]

{ #category : 'compatibility' }
SpJob >> label: aString [ 

	self title: aString
]

{ #category : 'accessing' }
SpJob >> lookup: lookupBlock ifNone: noneBlock [
	"Detect a job that satisfies the lookupBlock, or value noneBlock if none satisfies. 
	The lookup starts at myself, following recursevely through my parent."

	(lookupBlock value: self) ifTrue: [ ^ self ].
		
	^ parent 
		ifNil: noneBlock 
		ifNotNil: [ parent lookup: lookupBlock ifNone: noneBlock ]
]

{ #category : 'accessing' }
SpJob >> max [
	
	^ max
]

{ #category : 'accessing' }
SpJob >> max: aNumber [

	self migrateProgressWhileUpdatingBounds: [ max := aNumber ].
]

{ #category : 'private' }
SpJob >> migrateProgressWhileUpdatingBounds: aBlockChangingBounds [
	"Keep the progress value consistent while we change min / max"
	| progress |
	progress := self progress.
	aBlockChangingBounds value.
	self progress: progress.
]

{ #category : 'accessing' }
SpJob >> min [
	
	^ min
]

{ #category : 'accessing' }
SpJob >> min: aNumber [

	self migrateProgressWhileUpdatingBounds: [ min := aNumber ].
	self announceChange
]

{ #category : 'private' }
SpJob >> parent [

	^ parent
]

{ #category : 'private' }
SpJob >> parent: aJob [ 

	parent := aJob.
]

{ #category : 'private' }
SpJob >> prepareForRunning [

	isRunning := true.
	process := Processor activeProcess.
	self announce: JobStart
]

{ #category : 'progress' }
SpJob >> progress [
	"Avoid negative progress and divideByZero."

	^ min >= max 
		ifTrue: [ 1 ] 
		ifFalse: [ (currentValue - min) / (max - min) ]
]

{ #category : 'progress' }
SpJob >> progress: aNormalizedFloat [
	"Set the progress: 0.0 - 1.0"

	currentValue := (min + ((max - min) * aNormalizedFloat)).
	self announceChange
]

{ #category : 'compatibility' }
SpJob >> progressPercent: aNumber [ 
	
	self currentValue: aNumber
]

{ #category : 'private' }
SpJob >> removeChild: aJob [ 

	children remove: aJob.
]

{ #category : 'running' }
SpJob >> run [

	[ 
		self prepareForRunning.
	 	^ block cull: self ]
	ensure: [ self cleanupAfterRunning ]
]

{ #category : 'accessing' }
SpJob >> title [
	
	^ title
]

{ #category : 'accessing' }
SpJob >> title: anObject [
	
	title := anObject.
	self announceChange
]

{ #category : 'compatibility' }
SpJob >> value [

	^ self currentValue
]

{ #category : 'compatibility' }
SpJob >> value: aNumber [

	self currentValue: aNumber
]

{ #category : 'events' }
SpJob >> whenChangedDo: aBlock [

	self announcer when: JobChange do: aBlock
]

{ #category : 'events' }
SpJob >> whenEndDo: aBlock [

	self announcer when: JobEnd do: aBlock for: aBlock receiver
]

{ #category : 'events' }
SpJob >> whenStartDo: aBlock [

	self announcer when: JobStart do: aBlock for: aBlock receiver
]
