"
A presenter to display a job progress.

```
job := SpJob newBlock: [ :job |
	job title: 'Test'.
	job min: 1; max: 10.
	1 to: 10 do: [ :i | 
		job value: i. 
		100 milliSeconds wait ] ].

SpJobPresenter new 
	model: job;
	run.
```
"
Class {
	#name : #SpJobPresenter,
	#superclass : #SpPresenter,
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'progressBar',
		'progressLabel'
	],
	#category : #'Spec2-Core-Job'
}

{ #category : #examples }
SpJobPresenter class >> example [
	| job |

	job := SpJob newBlock: [ :aJob |
		aJob title: 'Test'.
		aJob min: 1; max: 10.
		1 to: 10 do: [ :i | 
			aJob title: ('Test {1}/10' format: {i}).
			aJob value: i. 
			100 milliSeconds wait ] ].

	self new 
		model: job;
		run
]

{ #category : #initialization }
SpJobPresenter >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		borderWidth: 10;
		spacing: 5;
		add: (progressLabel := self newLabel) expand: false;
		add: (progressBar := self newProgressBar) expand: false;
		yourself)
]

{ #category : #initialization }
SpJobPresenter >> initializeWindow: aWindowPresenter [ 

	aWindowPresenter 
		initialExtent: 500@70;
		withoutDecorations;
		beNotResizable;
		centered
]

{ #category : #private }
SpJobPresenter >> jobChanged: ann [ 

	self updatePresenter
]

{ #category : #private }
SpJobPresenter >> jobEnd: ann [ 

	self updatePresenter
]

{ #category : #private }
SpJobPresenter >> jobStart: ann [ 

	self updatePresenter
]

{ #category : #'accessing - model' }
SpJobPresenter >> model: aModel [

	model := aModel.
	self updateSubscriptions.		
	self updatePresenter
]

{ #category : #running }
SpJobPresenter >> run [

	self open.
	self model run.
	self withWindowDo: [ :window | window close ]
]

{ #category : #'accessing - model' }
SpJobPresenter >> setModelBeforeInitialization: aModel [

	model := aModel.
	self updateSubscriptions
]

{ #category : #initialization }
SpJobPresenter >> updatePresenter [
	| currentJob |

	currentJob := model ifNil: [ ^ SpJob empty ].
	
	progressLabel label: model title.
	progressBar fixedAt: model progress
]

{ #category : #private }
SpJobPresenter >> updateSubscriptions [
	
	model announcer weak 
		when: JobStart send: #jobStart: to: self;
		when: JobChange send: #jobChanged: to: self;
		when: JobEnd send: #jobEnd: to: self.

]
