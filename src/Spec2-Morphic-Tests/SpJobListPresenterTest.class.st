Class {
	#name : #SpJobListPresenterTest,
	#superclass : #SpSmokeTest,
	#category : #'Spec2-Morphic-Tests'
}

{ #category : #accessing }
SpJobListPresenterTest >> classToTest [
	^ SpJobListPresenter
]

{ #category : #tests }
SpJobListPresenterTest >> testJobIsFinishedWhenWaitingMoreThanWorkBlockDuration [

	| progress job |

	progress := 0.
	job := SpJob
			newTitle: 'some job'
			block: [ : myjob | 1 to: 25 do: [ :i | myjob value: i*4. 30 milliSeconds wait. ] ].
	[ presenter := SpJobListPresenter new 
		pushJob: job;
		yourself. ] fork. 
	
	1 second wait.
	self assert: job currentValue asInteger equals: job max 
]

{ #category : #tests }
SpJobListPresenterTest >> testJobIsNotFinishedWhenWaitingLessThanWorkBlockDuration [

	| progress job |

	progress := 0.
	job := SpJob
			newTitle: 'some job'
			block: [ : myjob | 1 to: 25 do: [ :i | myjob value: i*4. 60 milliSeconds wait. ] ].
	[ presenter := SpJobListPresenter new 
		pushJob: job;
		yourself. ] fork. 
	
	1 second wait.
	self deny: job currentValue asInteger equals: job max 
]

{ #category : #tests }
SpJobListPresenterTest >> testProgressDoesNotRefreshMoreThanRefreshRate [

	"Ensure progress presenter will not slow down the workblock by calling too many UI refresh"
	| job waitBetweenJobUpdate counter refreshRateInMs nbUpdates |

	waitBetweenJobUpdate := 30 milliSeconds.
	refreshRateInMs := 150.
	nbUpdates := 25.
	job := SpJob
			newTitle: 'some job'
			block: [ : myjob | 1 to: nbUpdates do: [ :i | myjob value: i * 4. waitBetweenJobUpdate wait. ] ].
	presenter := SpJobPresenter on: job.
	
	[ presenter 
		open; 
		refreshRateInMs: refreshRateInMs.
 	counter := ExecutionCounter installOn: (WorldMorph >> #doOneCycle) ast.
	presenter model run. ] 
	ensure: [ counter uninstall. presenter withWindowDo: [ :w | w close ] ].
	
	self assert: counter count <= ((waitBetweenJobUpdate asMilliSeconds * nbUpdates / refreshRateInMs) + 2). "Sometimes there is one more UI cycle"
]
