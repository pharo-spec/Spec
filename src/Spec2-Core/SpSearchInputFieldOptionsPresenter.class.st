"
Provides a presenter to allow the user to configure the type of search. 

A radio button group is used for the main search type:

- Substring search
- Regular expression search
- Exact matching

A separate checkboxes is used for case sensitive search. It's important to note that exact matching cannot be combined with substring or regex searches, as they are fundamentally different approaches.

"
Class {
	#name : 'SpSearchInputFieldOptionsPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'caseCheckBox',
		'regexpOptionButton',
		'exactOptionButton',
		'substringOptionButton'
	],
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'instance creation' }
SpSearchInputFieldOptionsPresenter class >> open [
	<script> 
	
	^ self new open
]

{ #category : 'accessing' }
SpSearchInputFieldOptionsPresenter >> caseCheckBox [

	^ caseCheckBox
]

{ #category : 'layout' }
SpSearchInputFieldOptionsPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		spacing: 2;
		add: substringOptionButton width: 95;
		add: regexpOptionButton width: 70;
		add: exactOptionButton width: 70;
		add: caseCheckBox width: 70;
		yourself
]

{ #category : 'accessing' }
SpSearchInputFieldOptionsPresenter >> exactOptionButton [

	^ exactOptionButton
]

{ #category : 'initialization' }
SpSearchInputFieldOptionsPresenter >> initializePresenters [

	super initializePresenters.
	self initializeSearchTypePresenters.
]

{ #category : 'initialization' }
SpSearchInputFieldOptionsPresenter >> initializeSearchTypePresenters [

	regexpOptionButton := self newRadioButton 
		label: 'Regexp';
		state: false;
		help: 'Use regular expression. For instance, use ^AB(.*)$ to match anything begining with AB';
		yourself.
		
	exactOptionButton := self newRadioButton 
		label: 'Exact';
		state: false;
		help: 'Use exact match';
		yourself.
		
	substringOptionButton := self newRadioButton
		label: 'Substring';
		help: 'Use substring search';
		yourself.
		
	substringOptionButton associatedRadioButtons: { exactOptionButton.  regexpOptionButton }.
	
	caseCheckBox := self newCheckBox 
		label: 'Case';
		state: false;
		help: 'Use match case';
		yourself.
]

{ #category : 'accessing' }
SpSearchInputFieldOptionsPresenter >> regexpOptionButton [

	^ regexpOptionButton
]

{ #category : 'updating' }
SpSearchInputFieldOptionsPresenter >> selectBlock [
	"Answer a <BlockClosure> with the matching strategy depending of the active searching options in the receiver"
	
	(regexpOptionButton isActive and: [ caseCheckBox isActive ])
		ifTrue: [ ^ [ : item : regex | regex asRegex  search: item ] ].
	(regexpOptionButton isActive and: [ caseCheckBox isActive not ])
		ifTrue: [ ^ [ : item : regex | regex asRegexIgnoringCase search: item ] ].

	(exactOptionButton isActive and: [ caseCheckBox isActive])
		ifTrue: [ ^ [ : item : pattern | item = pattern ]  ].
	(exactOptionButton isActive and: [ caseCheckBox isActive not ])
		ifTrue: [ ^ [ : item : pattern | item asLowercase = pattern asLowercase ] ].

	(substringOptionButton isActive and: [ caseCheckBox isActive ])
		ifTrue: [ ^ [ : item : pattern | item includesSubstring: pattern caseSensitive: true ] ].
	(substringOptionButton isActive and: [ caseCheckBox isActive not ])
		ifTrue: [ ^ [ : item : pattern | item includesSubstring: pattern caseSensitive: false ] ].

]

{ #category : 'accessing' }
SpSearchInputFieldOptionsPresenter >> substringBox [
	^ substringOptionButton
]
