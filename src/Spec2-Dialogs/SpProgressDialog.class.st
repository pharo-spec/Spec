"
A dialog to show a message and a progress bar.
"
Class {
	#name : #SpProgressDialog,
	#superclass : #SpDialogPresenter,
	#instVars : [
		'title',
		'label',
		'progressBar',
		'maxValue',
		'openAction'
	],
	#category : #'Spec2-Dialogs'
}

{ #category : #documentation }
SpProgressDialog class >> documentFactoryMethodSelector [
	
	^ #newProgress
]

{ #category : #example }
SpProgressDialog class >> example [

	self new
		title: 'Example Progress';
		label: 'You are seeing a progress dialog!';
		progressPercent: 30;
		openDialogWithSpec
]

{ #category : #example }
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

{ #category : #example }
SpProgressDialog class >> exampleModal [

	self new
		title: 'Example Progress';
		label: 'You are seeing a progress dialog!';
		progressPercent: 30;
		openModalWithSpec
]

{ #category : #accessing }
SpProgressDialog class >> extent [

	^ 600@100
]

{ #category : #'private actions' }
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

{ #category : #api }
SpProgressDialog >> informUser: aString during: aBlock [ 

	self informUserDuring: [ :bar | 
		bar label: aString. 
		aBlock value ]
]

{ #category : #api }
SpProgressDialog >> informUserDuring: aBlock [
	
	openAction := aBlock.
	self openModalWithSpec.
	parentWindow ifNotNil: [
		parentWindow takeKeyboardFocus ]
]

{ #category : #initialization }
SpProgressDialog >> initialize [

	super initialize.
	self title: 'Progress'.
	maxValue := 1.0
]

{ #category : #initialization }
SpProgressDialog >> initializeDialogWindow: aDialogWindowPresenter [
	
	aDialogWindowPresenter whenOpenedDo: [ self afterOpenAction ].
	
	self parentWindow 
		ifNotNil: [ :w | aDialogWindowPresenter centeredRelativeTo: w ] 
		ifNil: [ aDialogWindowPresenter centered ]
]

{ #category : #initialization }
SpProgressDialog >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		borderWidth: 5;
		add: (label := self newLabel) expand: false;
		add: (progressBar := self newProgressBar) expand: false;
		yourself)
]

{ #category : #initialization }
SpProgressDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: self title;
		initialExtent: self class extent
]

{ #category : #api }
SpProgressDialog >> label [

	^ label label
]

{ #category : #api }
SpProgressDialog >> label: aString [

	label label: aString
]

{ #category : #compatibility }
SpProgressDialog >> max: aNumber [
	"sets the maximum value. 
	 Affects how #value: is calculated"

	maxValue := aNumber asFloat
]

{ #category : #api }
SpProgressDialog >> progress [

	^ progressBar value
]

{ #category : #api }
SpProgressDialog >> progress: aFraction [

	progressBar fixedAt: aFraction
]

{ #category : #api }
SpProgressDialog >> progressPercent: aNumber [

	progressBar fixedPercentage: aNumber asFloat floor
]

{ #category : #initialization }
SpProgressDialog >> reset [

	self label: ''.
	self max: 1.0.
	self progress: 0.0.
	
]

{ #category : #api }
SpProgressDialog >> title [

	^ title
]

{ #category : #api }
SpProgressDialog >> title: aString [

	title := aString
]

{ #category : #compatibility }
SpProgressDialog >> value [

	^ self progress
]

{ #category : #compatibility }
SpProgressDialog >> value: aFraction [

	self progress: (aFraction / maxValue) asFloat
]
