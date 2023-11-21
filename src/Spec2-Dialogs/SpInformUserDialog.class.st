"
I'm a simple dialog to display something during a task proceeds.
"
Class {
	#name : 'SpInformUserDialog',
	#superclass : 'SpDialogPresenter',
	#instVars : [
		'title',
		'label',
		'progressBar',
		'openAction'
	],
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'documentation' }
SpInformUserDialog class >> documentFactoryMethodSelector [
	
	^ #newInformUserDuring
]

{ #category : 'examples' }
SpInformUserDialog class >> exampleInformUserDuring2 [

	self new
		title: 'Carefully listen';
		informUserDuring: [
				1 second wait ] 
]

{ #category : 'examples' }
SpInformUserDialog class >> exampleModal [

	self new
		title: 'Example Progress';
		label: 'You are seeing a progress dialog! Press escape!';
		openModal
]

{ #category : 'accessing' }
SpInformUserDialog class >> extent [

	^ 600@100
]

{ #category : 'private - actions' }
SpInformUserDialog >> afterOpenAction [
		
	openAction ifNil: [ ^ self ].

	[ 
		[ 
			openAction value.
			self accept ]
		on: Error 
		fork: [ :e | 
			self cancel.
			e pass ].
	] fork
]

{ #category : 'api' }
SpInformUserDialog >> informUser: aString during: aBlock [ 

	self informUserDuring: [ :bar | 
		bar label: aString. 
		aBlock value ]
]

{ #category : 'api' }
SpInformUserDialog >> informUserDuring: aBlock [
	
	openAction := aBlock.
	self openModal.
	parentWindow ifNotNil: [
		parentWindow takeKeyboardFocus ]
]

{ #category : 'initialization' }
SpInformUserDialog >> initialize [

	super initialize.
	self title: 'Listen User'.

]

{ #category : 'initialization' }
SpInformUserDialog >> initializeDialogWindow: aDialogWindowPresenter [
	
	aDialogWindowPresenter whenOpenedDo: [ self afterOpenAction ].
	
	self parentWindow 
		ifNotNil: [ :w | aDialogWindowPresenter centeredRelativeTo: w ] 
		ifNil: [ aDialogWindowPresenter centered ]
]

{ #category : 'initialization' }
SpInformUserDialog >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		borderWidth: 5;
		add: (label := self newLabel) expand: false;
		yourself)
]

{ #category : 'initialization' }
SpInformUserDialog >> initializeWindow: aWindowPresenter [

	aWindowPresenter 
		title: self title;
		initialExtent: self class extent
]

{ #category : 'api' }
SpInformUserDialog >> label [

	^ label label
]

{ #category : 'api' }
SpInformUserDialog >> label: aString [

	label label: aString
]

{ #category : 'initialization' }
SpInformUserDialog >> reset [

	self label: ''.
	
]

{ #category : 'api' }
SpInformUserDialog >> title [

	^ title
]

{ #category : 'api' }
SpInformUserDialog >> title: aString [

	title := aString
]
