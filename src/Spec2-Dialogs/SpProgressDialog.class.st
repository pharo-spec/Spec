"
I'm a simple form showing a dialog with progress bar during a task proceeds. 
The task can control the progress.
"
Class {
	#name : 'SpProgressDialog',
	#superclass : 'SpInformUserDialog',
	#instVars : [
		'maxValue'
	],
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'documentation' }
SpProgressDialog class >> documentFactoryMethodSelector [
	
	^ #newProgress
]

{ #category : 'examples' }
SpProgressDialog class >> exampleInformUserDuring [

	self new
		title: 'Example Progress';
		informUserDuring: [ :bar | 
			1 to: 10 do: [ :index | 
				bar 
					label: ('Step {1}...' format: { index });
					progressPercent: index * 10.
				1 second wait ] ]
]

{ #category : 'examples' }
SpProgressDialog class >> exampleInformUserDuring2 [

	self new
		title: 'Example Progress';
		informUserDuring: [ :bar | 
				1 second wait ] 
]

{ #category : 'examples' }
SpProgressDialog class >> exampleModal [

	self new
		title: 'Example Progress';
		label: 'You are seeing a progress dialog!';
		openModal
]

{ #category : 'private - actions' }
SpProgressDialog >> afterOpenAction [
		
	openAction ifNil: [ ^ self ].

	[ 
		[ 
			openAction value: self.
			self accept ]
		on: Error 
		fork: [ :e | 
			self cancel.
			e pass ].
	] fork
]

{ #category : 'api' }
SpProgressDialog >> informUser: aString during: aBlock [ 
	"Pay attention that the aBlock argument does not expect an argument representing the bar.
	Check class side example."
	
	self informUserDuring: [ :bar | 
		bar label: aString. 
		aBlock value ]
]

{ #category : 'initialization' }
SpProgressDialog >> initialize [

	super initialize.
	self title: 'Progress'.
	maxValue := 1.0
]

{ #category : 'initialization' }
SpProgressDialog >> initializeDialogWindow: aDialogWindowPresenter [
	
	aDialogWindowPresenter whenOpenedDo: [ self afterOpenAction ].
	
	self parentWindow 
		ifNotNil: [ :w | aDialogWindowPresenter centeredRelativeTo: w ] 
		ifNil: [ aDialogWindowPresenter centered ]
]

{ #category : 'initialization' }
SpProgressDialog >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		borderWidth: 5;
		add: (label := self newLabel) expand: false;
		add: (progressBar := self newProgressBar) expand: false;
		yourself)
]

{ #category : 'accessing' }
SpProgressDialog >> max: aNumber [
	"sets the maximum value. 
	 Affects how #value: is calculated"

	maxValue := aNumber asFloat
]

{ #category : 'progress' }
SpProgressDialog >> progress: aFraction [

	progressBar fixedAt: aFraction
]

{ #category : 'progress' }
SpProgressDialog >> progressPercent: aNumber [

	progressBar fixedPercentage: aNumber asFloat floor
]

{ #category : 'initialization' }
SpProgressDialog >> reset [

	self label: ''.
	self max: 1.0.
	self progress: 0.0.
	
]
