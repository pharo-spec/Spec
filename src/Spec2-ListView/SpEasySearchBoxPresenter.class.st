"
A component to display a search box (to be used with ""easy"" presenters)
"
Class {
	#name : 'SpEasySearchBoxPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'textInput',
		'closeButton'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'private' }
SpEasySearchBoxPresenter >> announceAccepted [
	
	self announcer announce: SpEasySearchBoxAccepted
]

{ #category : 'private' }
SpEasySearchBoxPresenter >> announceDismissed [
	
	self announcer announce: SpEasySearchBoxDismissed
]

{ #category : 'initialization' }
SpEasySearchBoxPresenter >> connectPresenters [

	textInput
		addAction: (SpAction
			newShortcutKey: Character escape asKeyCombination 
			action: [ self announceDismissed ]);
		addAction: (SpAction
			newShortcutKey: Character cr asKeyCombination 
			action: [ self announceAccepted ])
]

{ #category : 'api' }
SpEasySearchBoxPresenter >> cursorPositionIndex: aNumber [

	textInput cursorPositionIndex: aNumber
]

{ #category : 'layout' }
SpEasySearchBoxPresenter >> defaultLayout [
	
	^ SpBoxLayout newLeftToRight
		borderWidth: 3;
		spacing: 3;
		add: textInput;
		add: closeButton expand: false;
		yourself
]

{ #category : 'initialization' }
SpEasySearchBoxPresenter >> initializePresenters [

	self addStyle: 'searchBox'.

	textInput := self newSearchInput.
	closeButton := self newButton
		addStyle: 'small';
		addStyle: 'flat';
		icon: (self iconNamed: #close);
		action: [ 
			self hide.
			self announceDismissed ];
		yourself
]

{ #category : 'api' }
SpEasySearchBoxPresenter >> text [

	^ textInput text
]

{ #category : 'api' }
SpEasySearchBoxPresenter >> text: aString [

	textInput text: aString
]

{ #category : 'accessing' }
SpEasySearchBoxPresenter >> textInput [

	^ textInput
]

{ #category : 'api - selection' }
SpEasySearchBoxPresenter >> unselectAll [

	textInput unselectAll
]

{ #category : 'api - events' }
SpEasySearchBoxPresenter >> whenAcceptedDo: aBlock [

	self announcer 
		when: SpEasySearchBoxAccepted
		do: aBlock
		for: aBlock receiver.
]

{ #category : 'api - events' }
SpEasySearchBoxPresenter >> whenDismissedDo: aBlock [

	self announcer 
		when: SpEasySearchBoxDismissed 
		do: aBlock
		for: aBlock receiver.
]

{ #category : 'api - events' }
SpEasySearchBoxPresenter >> whenTextChangedDo: aBlock [

	textInput whenTextChangedDo: aBlock
]
