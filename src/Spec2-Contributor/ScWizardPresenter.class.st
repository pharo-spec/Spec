Class {
	#name : 'ScWizardPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'pagePresenter',
		'prevButton',
		'nextButton',
		'currentPage',
		'actionsLayout',
		'finishButton',
		'pages'
	],
	#category : 'Spec2-Contributor',
	#package : 'Spec2-Contributor'
}

{ #category : 'accessing' }
ScWizardPresenter class >> initialExtent [

	^ 600@400
]

{ #category : 'accessing' }
ScWizardPresenter class >> title [

	^ 'Wizard Unnamed'
]

{ #category : 'accessing' }
ScWizardPresenter >> currentPage [

	^ currentPage ifNil: [ 
		self moveTo: self pages first.
		currentPage ]
]

{ #category : 'actions' }
ScWizardPresenter >> doBack [
	
	self previousPage ifNotNil: [ :aPage |
		self moveTo: aPage.
		self updatePresenter ]
]

{ #category : 'actions' }
ScWizardPresenter >> doFinish [
	
	self window close
]

{ #category : 'actions' }
ScWizardPresenter >> doNext [
	
	self nextPage ifNotNil: [ :aPage |
		self moveTo: aPage.
		self updatePresenter ]
]

{ #category : 'initialization' }
ScWizardPresenter >> initializePresenters [

	self layout: (SpBoxLayout newTopToBottom
		add: (pagePresenter := self currentPage);
		add: (actionsLayout := SpBoxLayout newLeftToRight
				spacing: 5;
				borderWidth: 5;
				yourself) 
			expand: false;
		yourself).
	
		prevButton := self newButton
			label: 'Back';
			action: [ self doBack ];
			yourself.
		nextButton := self newButton
			label: 'Next';
			action: [ self doNext ];
			yourself.
		finishButton := self newButton
			label: 'Finish';
			action: [ self doFinish ];
			yourself
]

{ #category : 'initialization' }
ScWizardPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		initialExtent: self class initialExtent;
		title: self class title
]

{ #category : 'testing' }
ScWizardPresenter >> isFirst: aPage [ 

	^ self pages first = aPage
]

{ #category : 'testing' }
ScWizardPresenter >> isLast: aPage [ 

	^ self pages last = aPage
]

{ #category : 'private' }
ScWizardPresenter >> moveTo: aPage [

	currentPage = aPage ifTrue: [ ^ self ].
	
	aPage owner: self.
	currentPage ifNotNil: [ 
		self layout 
			replace: currentPage 
			with: aPage ].
	currentPage := aPage
]

{ #category : 'private factory' }
ScWizardPresenter >> newPages [

	^ self subclassResponsibility
]

{ #category : 'private' }
ScWizardPresenter >> nextPage [
	| nextPage |
	
	nextPage := self pages after: self currentPage.
	[ nextPage isVisible ]
	whileFalse: [ 
		nextPage := self pages after: self currentPage ].
	^ nextPage
]

{ #category : 'accessing' }
ScWizardPresenter >> pages [

	^ pages ifNil: [ pages := self newPages ]
]

{ #category : 'private' }
ScWizardPresenter >> previousPage [
	| previousPage |
	
	previousPage := self pages before: self currentPage.
	[ previousPage isVisible ]
	whileFalse: [ 
		previousPage := self pages before: self currentPage ].
	^ previousPage
]

{ #category : 'initialization' }
ScWizardPresenter >> updatePresenter [

	actionsLayout removeAll.
	(self isFirst: self currentPage) 
		ifFalse: [ actionsLayout addLast: prevButton ].
	(self isLast: self currentPage)
		ifTrue: [ actionsLayout addLast: finishButton ]
		ifFalse: [ actionsLayout addLast: nextButton ]
]
